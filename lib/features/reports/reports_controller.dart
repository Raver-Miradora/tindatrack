import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../core/providers.dart';

class FinancialReport {
  final double estSales;
  final double totalVariance;
  final double shrinkageRate;

  FinancialReport({
    required this.estSales,
    required this.totalVariance,
    required this.shrinkageRate,
  });

  factory FinancialReport.empty() => FinancialReport(estSales: 0, totalVariance: 0, shrinkageRate: 0);
}

final financialReportProvider = StreamProvider<FinancialReport>((ref) {
  final db = ref.watch(databaseProvider);
  
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

  // Join CountItems with Products to get prices
  final query = db.select(db.countItems).join([
    innerJoin(db.products, db.products.id.equalsExp(db.countItems.productId)),
  ])..where(db.countItems.countedAt.isBetweenValues(startOfMonth, endOfMonth));

  return query.watch().map((rows) {
    double totalSales = 0;
    double shrinkage = 0;

    for (final row in rows) {
      final item = row.readTable(db.countItems);
      final product = row.readTable(db.products);
      
      final price = product.averageSellingPrice ?? 0.0;
      final cost = product.averageCost;

      // Positive variance = items missing (likely sold)
      if (item.variance > 0) {
        totalSales += item.variance * price;
        
        // If there's a reason like 'Shrinkage', 'Theft', or 'Loss', add to variance total
        if (item.varianceReason != null && item.varianceReason != 'Sale') {
          shrinkage += item.variance * cost;
        }
      }
    }

    final rate = totalSales > 0 ? (shrinkage / totalSales) * 100 : 0.0;

    return FinancialReport(
      estSales: totalSales,
      totalVariance: shrinkage,
      shrinkageRate: rate,
    );
  });
});
