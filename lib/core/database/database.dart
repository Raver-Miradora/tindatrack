import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Products, StockInEvents, StockInItems, CountSessions, CountItems, Alerts, Users, AuditLog, CountDrafts, SalesTransactions, Customers, UtangLedger, StoreExpenses, CashierShifts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _createIndexes(m);
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // PRODUCTION SAFEGUARD: Additive-only migrations. Never drop tables.
        if (from < 2) {
          // v2: Added SalesTransactions table for the Daily Sales Ledger.
          await m.createTable(salesTransactions);
          await m.database.customStatement(
            'CREATE INDEX IF NOT EXISTS idx_sales_timestamp ON sales_transactions(timestamp);'
          );
        }
        if (from < 3) {
          // v3: Added isSeeded flag for Developer Mode seed export.
          await m.addColumn(products, products.isSeeded);
          // Back-fill: all rows that existed before v3 are treated as seeded.
          await m.database.customStatement(
            "UPDATE products SET is_seeded = 1"
          );
        }
        if (from < 4) {
          // v4: Added Accounts Receivable (Utang) system.
          await m.createTable(customers);
          await m.createTable(utangLedger);
          await m.addColumn(salesTransactions, salesTransactions.paymentMethod);
          await m.database.customStatement(
            "UPDATE sales_transactions SET payment_method = 'CASH'"
          );
        }
        if (from < 5) {
          // v5: Added Store Expenses tracker
          await m.createTable(storeExpenses);
        }
        if (from < 6) {
          // v6: Added Shift Handover System
          await m.createTable(cashierShifts);
          await m.addColumn(salesTransactions, salesTransactions.shiftId);
          await m.addColumn(utangLedger, utangLedger.shiftId);
          await m.addColumn(storeExpenses, storeExpenses.shiftId);
        }
        if (from < 7) {
          // v7: Added itemsSnapshot to UtangLedger for itemized debt tracking.
          await m.addColumn(utangLedger, utangLedger.itemsSnapshot);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        await customStatement('PRAGMA journal_mode = WAL');
      },
    );
  }

  Future<void> _createIndexes(Migrator m) async {
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_products_barcode ON products(barcode);');
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);');
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_stock_items_product ON stock_in_items(product_id);');
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_count_items_product ON count_items(product_id);');
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_count_items_date ON count_items(counted_at);');
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_audit_log_timestamp ON audit_log(timestamp);');
    await m.database.customStatement('CREATE INDEX IF NOT EXISTS idx_alerts_status ON alerts(status);');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tindatrack.sqlite'));
    return NativeDatabase(file);
  });
}
