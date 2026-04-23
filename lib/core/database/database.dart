import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Products, StockInEvents, StockInItems, CountSessions, CountItems, Alerts, Users, AuditLog, CountDrafts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _createIndexes(m);
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Destructive for dev-only version 1 -> 2
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
            await m.createTable(table);
          }
        }
        
        if (from < 3) {
          await _createIndexes(m);
        }

        if (from < 4) {
          // Add currentStock column to products
          await m.addColumn(products, products.currentStock);
        }

        if (from < 5) {
          // Add countDrafts table
          await m.createTable(countDrafts);
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
