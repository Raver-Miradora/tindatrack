import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import '../../core/database/database.dart';
import '../../core/providers.dart';

// ── Data Models ───────────────────────────────────────────────────────────────

class SalesPeriodStats {
  final double totalRevenue;
  final int transactionCount;

  const SalesPeriodStats({required this.totalRevenue, required this.transactionCount});
}

class ProductSalesStat {
  final String productName;
  final int quantitySold;
  final double revenue;

  const ProductSalesStat({
    required this.productName,
    required this.quantitySold,
    required this.revenue,
  });
}

class AnalyticsData {
  final SalesPeriodStats today;
  final SalesPeriodStats thisWeek;
  final SalesPeriodStats thisMonth;
  final SalesPeriodStats thisYear;
  final List<ProductSalesStat> topEarners;
  final List<ProductSalesStat> topSellers;

  const AnalyticsData({
    required this.today,
    required this.thisWeek,
    required this.thisMonth,
    required this.thisYear,
    required this.topEarners,
    required this.topSellers,
  });
}

// ── Helper ───────────────────────────────────────────────────────────────────

/// Parse itemsSnapshot text like "2x Coke, 1x Tuna, Misc PHP 5.00"
/// Returns a map of {productName: quantity}.
Map<String, int> _parseSnapshot(String snapshot) {
  final map = <String, int>{};
  final parts = snapshot.split(',');
  for (final part in parts) {
    final trimmed = part.trim();
    // Skip misc entries ("Misc PHP 5.00")
    if (trimmed.startsWith('Misc ')) continue;
    // Match pattern: "NxName" e.g. "2x Coke Mismo"
    final match = RegExp(r'^(\d+)x\s+(.+)$').firstMatch(trimmed);
    if (match != null) {
      final qty = int.tryParse(match.group(1)!) ?? 1;
      final name = match.group(2)!.trim();
      map[name] = (map[name] ?? 0) + qty;
    }
  }
  return map;
}

SalesPeriodStats _aggregate(List<SalesTransaction> txs) {
  return SalesPeriodStats(
    totalRevenue: txs.fold(0.0, (sum, t) => sum + t.totalAmount),
    transactionCount: txs.length,
  );
}

DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);
DateTime _endOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 23, 59, 59);

// ── Provider ─────────────────────────────────────────────────────────────────

final analyticsProvider = FutureProvider.autoDispose<AnalyticsData>((ref) async {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();

  // ── Time boundaries ─────────────────────────────────────────────────────────
  final todayStart = _startOfDay(now);
  final todayEnd = _endOfDay(now);

  final weekStart = now.subtract(Duration(days: now.weekday - 1));
  final weekStartClean = _startOfDay(weekStart);

  final monthStart = DateTime(now.year, now.month, 1);
  final yearStart = DateTime(now.year, 1, 1);

  final thirtyDaysAgo = now.subtract(const Duration(days: 30));

  // ── Fetch all needed transactions ───────────────────────────────────────────
  final allTxs = await (db.select(db.salesTransactions)
        ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]))
      .get();

  // Period buckets
  final todayTxs   = allTxs.where((t) => t.timestamp.isAfter(todayStart) && t.timestamp.isBefore(todayEnd)).toList();
  final weekTxs    = allTxs.where((t) => t.timestamp.isAfter(weekStartClean)).toList();
  final monthTxs   = allTxs.where((t) => t.timestamp.isAfter(monthStart)).toList();
  final yearTxs    = allTxs.where((t) => t.timestamp.isAfter(yearStart)).toList();
  final last30Txs  = allTxs.where((t) => t.timestamp.isAfter(thirtyDaysAgo)).toList();

  // ── Product Aggregation for last 30 days ────────────────────────────────────
  final qtyMap     = <String, int>{};     // productName -> total qty
  final revenueMap = <String, double>{};  // productName -> total revenue

  for (final tx in last30Txs) {
    final items = _parseSnapshot(tx.itemsSnapshot);
    final itemCount = items.values.fold(0, (a, b) => a + b);
    
    items.forEach((name, qty) {
      qtyMap[name] = (qtyMap[name] ?? 0) + qty;
      // Distribute revenue proportionally by quantity share
      final share = itemCount > 0 ? qty / itemCount : 0.0;
      revenueMap[name] = (revenueMap[name] ?? 0.0) + (tx.totalAmount * share);
    });
  }

  // Build and sort product stats
  final allProductStats = qtyMap.keys.map((name) => ProductSalesStat(
    productName: name,
    quantitySold: qtyMap[name]!,
    revenue: revenueMap[name] ?? 0.0,
  )).toList();

  final topSellers = List<ProductSalesStat>.from(allProductStats)
    ..sort((a, b) => b.quantitySold.compareTo(a.quantitySold));

  final topEarners = List<ProductSalesStat>.from(allProductStats)
    ..sort((a, b) => b.revenue.compareTo(a.revenue));

  return AnalyticsData(
    today:     _aggregate(todayTxs),
    thisWeek:  _aggregate(weekTxs),
    thisMonth: _aggregate(monthTxs),
    thisYear:  _aggregate(yearTxs),
    topEarners: topEarners.take(10).toList(),
    topSellers: topSellers.take(10).toList(),
  );
});
