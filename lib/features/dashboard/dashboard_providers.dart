import 'package:flutter/material.dart';
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
        ..limit(10))
      .watch();
});

final productsProvider = StreamProvider<List<Product>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.products).watch();
});

final lowStockItemsProvider = StreamProvider<List<Product>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.products)
    ..where((p) => p.isActive.equals(true) & (p.currentStock.isSmallerOrEqual(p.reorderPoint))))
  .watch();
});

class DashboardStatus {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final int alertCount;

  DashboardStatus({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    this.alertCount = 0,
  });
}

final dashboardStatusProvider = Provider<AsyncValue<DashboardStatus>>((ref) {
  final alertsAsync = ref.watch(activeAlertsProvider);
  final lowStockAsync = ref.watch(lowStockItemsProvider);

  return alertsAsync.when(
    data: (alerts) {
      return lowStockAsync.when(
        data: (lowStock) {
          if (alerts.isNotEmpty) {
            return AsyncData(DashboardStatus(
              title: '${alerts.length} System Alert(s)',
              subtitle: 'Urgent system actions required.',
              color: Colors.red,
              icon: Icons.error_outline,
              alertCount: alerts.length,
            ));
          } else if (lowStock.isNotEmpty) {
            return AsyncData(DashboardStatus(
              title: 'Low Stock Warning',
              subtitle: '${lowStock.length} items need restocking soon.',
              color: Colors.orange,
              icon: Icons.warning_amber_rounded,
              alertCount: lowStock.length,
            ));
          } else {
            return AsyncData(DashboardStatus(
              title: 'Store is Running Smoothly',
              subtitle: 'All stock levels are healthy.',
              color: Colors.green,
              icon: Icons.check_circle_outline,
            ));
          }
        },
        loading: () => const AsyncLoading(),
        error: (e, st) => AsyncError(e, st),
      );
    },
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
  );
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
}

final predictiveProductsProvider = Provider<List<PredictedProduct>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  
  return productsAsync.when(
    data: (products) {
      final List<PredictedProduct> results = [];

      for (final product in products) {
        if (product.isActive && product.burnRatePerDay > 0) {
          final daysLeft = product.currentStock / product.burnRatePerDay;
          results.add(PredictedProduct(
            product: product,
            daysLeft: daysLeft,
            isCritical: daysLeft < 3.0,
          ));
        }
      }

      results.sort((a, b) => a.daysLeft.compareTo(b.daysLeft));
      return results.take(10).toList();
    },
    loading: () => [],
    error: (_, _) => [],
  );
});
