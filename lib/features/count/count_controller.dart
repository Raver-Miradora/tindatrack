import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/burn_rate_engine.dart';

class CountItemEntry {
  final Product product;
  final double expectedQuantity;
  final double actualQuantity;

  CountItemEntry({
    required this.product,
    required this.expectedQuantity,
    required this.actualQuantity,
  });

  CountItemEntry copyWith({
    Product? product,
    double? expectedQuantity,
    double? actualQuantity,
  }) {
    return CountItemEntry(
      product: product ?? this.product,
      expectedQuantity: expectedQuantity ?? this.expectedQuantity,
      actualQuantity: actualQuantity ?? this.actualQuantity,
    );
  }

  double get variance => expectedQuantity - actualQuantity;
}

class CountSessionNotifier extends AsyncNotifier<List<CountItemEntry>> {
  @override
  Future<List<CountItemEntry>> build() async {
    final db = ref.read(databaseProvider);
    
    // 1. Fetch active products
    final products = await (db.select(db.products)
      ..where((p) => p.isActive.equals(true))
      ..orderBy([(p) => drift.OrderingTerm(expression: p.category)]))
    .get();

    // 2. Fetch existing drafts
    final drafts = await db.select(db.countDrafts).get();
    final draftMap = {for (var d in drafts) d.productId: d.actualQuantity};

    return products.map((p) => CountItemEntry(
      product: p,
      expectedQuantity: p.currentStock,
      actualQuantity: draftMap[p.id] ?? p.currentStock,
    )).toList();
  }

  Future<void> updateQuantity(String productId, double actual) async {
    final currentItems = state.value ?? [];
    
    // Update local state
    state = AsyncData(currentItems.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(actualQuantity: actual);
      }
      return item;
    }).toList());

    // Persist draft to DB (debounced or immediate, immediate for reliability here)
    final db = ref.read(databaseProvider);
    await db.into(db.countDrafts).insertOnConflictUpdate(
      CountDraftsCompanion.insert(
        productId: productId,
        actualQuantity: actual,
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<bool> finalizeCount() async {
    final items = state.value;
    if (items == null || items.isEmpty) return false;

    final db = ref.read(databaseProvider);
    final sessionId = const Uuid().v4();
    final now = DateTime.now();

    try {
      // Use Batch for 10x performance improvement
      await db.transaction(() async {
        // 1. Create the session
        await db.into(db.countSessions).insert(
          CountSessionsCompanion.insert(
            id: sessionId,
            countType: 'full',
            startedAt: drift.Value(now),
            completedAt: drift.Value(now),
          ),
        );

        await db.batch((batch) {
          for (final item in items) {
            // 2. Save items
            batch.insert(
              db.countItems,
              CountItemsCompanion.insert(
                id: const Uuid().v4(),
                countSessionId: sessionId,
                productId: item.product.id,
                expectedQuantity: item.expectedQuantity,
                actualQuantity: item.actualQuantity,
                variance: item.variance,
                countedAt: drift.Value(now),
              ),
            );

            // 3. Update Product Baseline
            batch.update(
              db.products,
              ProductsCompanion(
                lastActualQuantity: drift.Value(item.actualQuantity),
                currentStock: drift.Value(item.actualQuantity),
                lastCountedAt: drift.Value(now),
                updatedAt: drift.Value(now),
              ),
              where: (p) => p.id.equals(item.product.id),
            );

            // 4. Log Discrepancy if exists
            if (item.variance != 0) {
              batch.insert(
                db.auditLog,
                AuditLogCompanion.insert(
                  id: const Uuid().v4(),
                  actionType: 'Count Discrepancy',
                  targetType: 'product',
                  targetId: item.product.id,
                  beforeSnapshot: drift.Value(jsonEncode({"expected": item.expectedQuantity})),
                  afterSnapshot: drift.Value(jsonEncode({
                    "actual": item.actualQuantity,
                    "variance": item.variance,
                  })),
                  timestamp: drift.Value(now),
                ),
              );
            }
          }
        });

        // 5. Clear all drafts on success
        await db.delete(db.countDrafts).go();
      });

      // 6. Recalculate Burn Rates (Optimized: only if variance exists)
      final engine = BurnRateEngine(db);
      for (final item in items) {
        if (item.variance != 0) {
          await engine.updateBurnRate(item.product.id);
        }
      }

      ref.invalidateSelf();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllDrafts() async {
    final db = ref.read(databaseProvider);
    await db.delete(db.countDrafts).go();
    ref.invalidateSelf();
  }
}

// Grouped products provider for the UI
final groupedCountItemsProvider = Provider<AsyncValue<Map<String, List<CountItemEntry>>>>((ref) {
  final asyncItems = ref.watch(countSessionNotifierProvider);
  
  return asyncItems.whenData((items) {
    final Map<String, List<CountItemEntry>> grouped = {};
    for (final item in items) {
      grouped.putIfAbsent(item.product.category, () => []).add(item);
    }
    return grouped;
  });
});

final countSessionNotifierProvider = AsyncNotifierProvider<CountSessionNotifier, List<CountItemEntry>>(CountSessionNotifier.new);

final pastSessionsProvider = StreamProvider<List<CountSession>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.countSessions)
    ..orderBy([(u) => drift.OrderingTerm(expression: u.completedAt, mode: drift.OrderingMode.desc)]))
  .watch();
});
