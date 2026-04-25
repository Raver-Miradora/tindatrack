import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../core/providers.dart';

class FinancialReport {
  final double estSales;
  final double totalVariance;
  final double shrinkageRate;
  final double totalInventoryValue;
  final int totalSkusInStock;
  final int stockoutRiskCount;
  final DateTime lastUpdated; 

  FinancialReport({
    required this.estSales,
    required this.totalVariance,
    required this.shrinkageRate,
    required this.totalInventoryValue,
    required this.totalSkusInStock,
    required this.stockoutRiskCount,
    required this.lastUpdated,
  });

  factory FinancialReport.empty() => FinancialReport(
    estSales: 0, 
    totalVariance: 0, 
    shrinkageRate: 0, 
    totalInventoryValue: 0,
    totalSkusInStock: 0,
    stockoutRiskCount: 0,
    lastUpdated: DateTime.now(),
  );
}

final financialReportProvider = StreamProvider.autoDispose<FinancialReport>((ref) {
  final db = ref.watch(databaseProvider);
  
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

  // Watch products and count items for updates
  return db.customSelect(
    'SELECT 1', 
    readsFrom: {db.countItems, db.products}
  ).watch().asyncMap((_) async {
    
    // 1. Calculate Asset Value (ONLY for items in stock)
    final assetQuery = db.select(db.products)
      ..where((p) => p.isActive.equals(true) & p.currentStock.isBiggerThanValue(0));
    
    final stockedProducts = await assetQuery.get();
    
    double inventoryValue = 0;
    int stockoutRisks = 0;
    
    for (final p in stockedProducts) {
      final price = p.averageSellingPrice ?? 0.0;
      inventoryValue += p.currentStock * price;
      
      // Stockout risk: days left < 3 based on burn rate
      if (p.burnRatePerDay > 0) {
        final daysLeft = p.currentStock / p.burnRatePerDay;
        if (daysLeft < 3.0) stockoutRisks++;
      }
    }

    // 2. Calculate Variance & Sales (Monthly)
    final performanceQuery = db.select(db.countItems).join([
      innerJoin(db.products, db.products.id.equalsExp(db.countItems.productId)),
    ])..where(db.countItems.countedAt.isBetweenValues(startOfMonth, endOfMonth));

    final performanceRows = await performanceQuery.get();
    double totalSales = 0;
    double shrinkage = 0;

    for (final row in performanceRows) {
      final item = row.readTable(db.countItems);
      final product = row.readTable(db.products);
      final price = product.averageSellingPrice ?? 0.0;
      final cost = product.averageCost;

      if (item.variance > 0) {
        totalSales += item.variance * price;
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
      totalInventoryValue: inventoryValue,
      totalSkusInStock: stockedProducts.length,
      stockoutRiskCount: stockoutRisks,
      lastUpdated: DateTime.now(),
    );
  });
});
