import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/providers.dart';
import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';

// HARDENING: Added .autoDispose to all providers to ensure memory is freed when screens are closed

final activeAlertsProvider = StreamProvider.autoDispose<List<Alert>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.alerts)..where((a) => a.status.equals('open'))).watch();
});

final recentActivityProvider = StreamProvider.autoDispose<List<AuditLogData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.auditLog)
        ..orderBy([(u) => OrderingTerm(expression: u.timestamp, mode: OrderingMode.desc)])
        ..limit(10))
      .watch();
});

final productsProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.products).watch();
});

final lowStockItemsProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.products)..where((p) {
    // Only alert if the product has been explicitly "handled" (stocked in or counted)
    final stockInItems = db.selectOnly(db.stockInItems)..addColumns([db.stockInItems.productId]);
    final countItems = db.selectOnly(db.countItems)..addColumns([db.countItems.productId]);
    
    return p.isActive.equals(true) & 
           (p.currentStock.isSmallerOrEqual(p.reorderPoint)) & 
           (p.id.isInQuery(stockInItems) | p.id.isInQuery(countItems));
  })).watch();
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

final dashboardStatusProvider = Provider.autoDispose<AsyncValue<DashboardStatus>>((ref) {
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

final predictiveProductsProvider = Provider.autoDispose<List<PredictedProduct>>((ref) {
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

// Live Cash Drawer Math
class LiveCashDrawerData {
  final double baseFloat;
  final double cashSales;
  final double expenses;
  final double utangPaymentsReceived;
  final double cashLoansGiven;

  double get currentCash => baseFloat + cashSales - expenses + utangPaymentsReceived - cashLoansGiven;

  LiveCashDrawerData({
    required this.baseFloat,
    required this.cashSales,
    required this.expenses,
    required this.utangPaymentsReceived,
    required this.cashLoansGiven,
  });
}

final liveCashDrawerProvider = StreamProvider.autoDispose<LiveCashDrawerData>((ref) async* {
  final db = ref.watch(databaseProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  
  // Base float from settings
  final baseFloat = prefs.getDouble('base_cash_float') ?? 0.0;
  
  // Create a combined stream of all tables that affect the drawer
  final combinedStream = Rx.combineLatest4(
    db.select(db.salesTransactions).watch(),
    db.select(db.storeExpenses).watch(),
    db.select(db.utangLedger).watch(),
    Stream.value(baseFloat), // To trigger updates if we change it, though technically we might need to invalidate
    (a, b, c, float) => true,
  );

  await for (final _ in combinedStream) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    // Cash Sales Today
    final sales = await (db.select(db.salesTransactions)
      ..where((t) => t.paymentMethod.equals('CASH'))
      ..where((t) => t.timestamp.isBiggerOrEqualValue(startOfDay)))
    .get();
    final cashSales = sales.fold(0.0, (sum, t) => sum + t.totalAmount);

    // Expenses Today
    final expenses = await (db.select(db.storeExpenses)
      ..where((t) => t.timestamp.isBiggerOrEqualValue(startOfDay)))
    .get();
    final totalExpenses = expenses.fold(0.0, (sum, t) => sum + t.amount);

    // Utang Activity Today
    final utangs = await (db.select(db.utangLedger)
      ..where((t) => t.timestamp.isBiggerOrEqualValue(startOfDay)))
    .get();
    
    double utangPaymentsReceived = 0.0;
    double cashLoansGiven = 0.0;
    
    for (final u in utangs) {
      if (u.amount < 0) {
        utangPaymentsReceived += u.amount.abs();
      } else if (u.amount > 0 && u.itemsSnapshot == 'Cash Loan') {
        cashLoansGiven += u.amount;
      }
    }

    // Refresh float value directly to be safe
    final currentBaseFloat = ref.read(sharedPreferencesProvider).getDouble('base_cash_float') ?? 0.0;

    yield LiveCashDrawerData(
      baseFloat: currentBaseFloat,
      cashSales: cashSales,
      expenses: totalExpenses,
      utangPaymentsReceived: utangPaymentsReceived,
      cashLoansGiven: cashLoansGiven,
    );
  }
});
