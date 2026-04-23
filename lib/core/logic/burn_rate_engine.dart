import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../database/database.dart';

class BurnRateEngine {
  final AppDatabase db;

  BurnRateEngine(this.db);

  /// Computes the new burn rate for a product based on historical counts and deliveries.
  Future<void> updateBurnRate(String productId) async {
    // 1. Fetch the last 4 successful counts
    final counts = await (db.select(db.countItems)
      ..where((c) => c.productId.equals(productId))
      ..orderBy([(u) => drift.OrderingTerm(expression: u.countedAt, mode: drift.OrderingMode.desc)])
      ..limit(4))
    .get();

    if (counts.length < 2) return;

    final List<double> dailyRates = [];

    // 2. Fetch ALL deliveries for the entire data span in ONE query for performance
    final startDate = counts.last.countedAt;
    final endDate = counts.first.countedAt;

    final allDeliveries = await (db.select(db.stockInItems).join([
      drift.innerJoin(db.stockInEvents, db.stockInEvents.id.equalsExp(db.stockInItems.stockInEventId))
    ])
      ..where(db.stockInItems.productId.equals(productId))
      ..where(db.stockInEvents.deliveryDate.isBiggerThanValue(startDate))
      ..where(db.stockInEvents.deliveryDate.isSmallerOrEqualValue(endDate)))
    .get();

    // 3. Process intervals using the pre-fetched delivery list
    for (int i = 0; i < counts.length - 1; i++) {
      final currentCount = counts[i];
      final previousCount = counts[i+1];

      final duration = currentCount.countedAt.difference(previousCount.countedAt);
      if (duration.inHours < 1) continue;

      // Filter local list for this interval
      double additions = 0.0;
      for (final row in allDeliveries) {
        final deliveryDate = row.readTable(db.stockInEvents).deliveryDate;
        if (deliveryDate.isAfter(previousCount.countedAt) && deliveryDate.isBefore(currentCount.countedAt) || deliveryDate.isAtSameMomentAs(currentCount.countedAt)) {
          additions += row.readTable(db.stockInItems).quantity;
        }
      }

      final consumption = previousCount.actualQuantity + additions - currentCount.actualQuantity;
      final dailyRate = consumption / (duration.inMinutes / (24 * 60));
      dailyRates.add(dailyRate < 0 ? 0 : dailyRate);
    }

    if (dailyRates.isEmpty) return;

    // 4. Weighted Moving Average calculation
    double finalBurnRate = 0.0;
    if (dailyRates.length == 1) {
      finalBurnRate = dailyRates[0];
    } else if (dailyRates.length == 2) {
      finalBurnRate = (dailyRates[0] * 0.6) + (dailyRates[1] * 0.4);
    } else {
      finalBurnRate = (dailyRates[0] * 0.5) + (dailyRates[1] * 0.3) + (dailyRates[2] * 0.2);
    }

    // 5. Outlier Clamping
    final product = await (db.select(db.products)..where((p) => p.id.equals(productId))).getSingle();
    final currentAverage = product.burnRatePerDay;
    if (currentAverage > 0 && finalBurnRate > (currentAverage * 3.0)) {
       finalBurnRate = currentAverage * 3.0;
    }

    // 6. Final Update in single write
    await (db.update(db.products)..where((p) => p.id.equals(productId)))
      .write(ProductsCompanion(
        burnRatePerDay: drift.Value(finalBurnRate),
        lastActualQuantity: drift.Value(counts[0].actualQuantity),
        currentStock: drift.Value(counts[0].actualQuantity), // Reset estimate to verified physical stock
        lastCountedAt: drift.Value(counts[0].countedAt),
        updatedAt: drift.Value(DateTime.now()),
      ));
    
    // 7. Alert check
    if (finalBurnRate > 0) {
      final double daysLeft = counts[0].actualQuantity / finalBurnRate;
      if (daysLeft < 3.0) {
        await db.into(db.alerts).insert(
          AlertsCompanion.insert(
            id: const Uuid().v4(),
            productId: drift.Value(productId),
            alertType: 'low_stock',
            message: 'Predicted stockout in ${daysLeft.toStringAsFixed(1)} days.',
            severity: daysLeft < 1 ? 'critical' : 'warning',
          ),
        );
      }
    }
  }

  Future<void> updateAll() async {
    final products = await db.select(db.products).get();
    // Wrap in one giant transaction to avoid constant PRAGMA overhead and ensure data atomicity
    await db.transaction(() async {
      for (final product in products) {
        await updateBurnRate(product.id);
      }
    });
  }
}
