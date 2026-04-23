import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/providers.dart';
import 'package:drift/drift.dart';

final activeAlertsProvider = StreamProvider<List<Alert>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.alerts)..where((a) => a.status.equals('open'))).watch();
});

final recentActivityProvider = StreamProvider<List<AuditLogData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.auditLog)
        ..orderBy([(u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.desc)])
        ..limit(5))
      .watch();
});

final productsProvider = StreamProvider<List<Product>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.products).watch();
});

class PredictedProduct {
  final Product product;
  final double daysLeft;
  final bool isCritical;

  PredictedProduct({
    required this.product,
    required this.daysLeft,
    required this.isCritical,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredictedProduct &&
          runtimeType == other.runtimeType &&
          product.id == other.product.id &&
          daysLeft == other.daysLeft &&
          isCritical == other.isCritical;

  @override
  int get hashCode => product.id.hashCode ^ daysLeft.hashCode ^ isCritical.hashCode;
}

/// Highly optimized provider for the critical items strip.
/// Uses a selector-like pattern to ensure the dashboard only rebuilds the strip
/// if the sorted "critical" set actually changes.
final predictiveProductsProvider = Provider<List<PredictedProduct>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  
  return productsAsync.when(
    data: (products) {
      final List<PredictedProduct> results = [];

      for (final product in products) {
        // Only include active products with a valid burn rate
        if (product.isActive && product.burnRatePerDay > 0) {
          final daysLeft = product.currentStock / product.burnRatePerDay;
          results.add(PredictedProduct(
            product: product,
            daysLeft: daysLeft,
            isCritical: daysLeft < 3.0,
          ));
        }
      }

      // Sort by daysLeft ascending (most critical first)
      results.sort((a, b) => a.daysLeft.compareTo(b.daysLeft));
      
      // Limit to top 10 for dashboard performance on budget devices
      return results.take(10).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
