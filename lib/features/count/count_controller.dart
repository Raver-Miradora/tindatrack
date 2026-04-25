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

// FIXED: Using Notifier instead of StateProvider for Riverpod 3.x compatibility
class ShowAllCountItemsNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  
  void toggle(bool val) => state = val;
}

final showAllCountItemsProvider = NotifierProvider<ShowAllCountItemsNotifier, bool>(ShowAllCountItemsNotifier.new);

class CountSessionNotifier extends AsyncNotifier<List<CountItemEntry>> {
  @override
  Future<List<CountItemEntry>> build() async {
    final db = ref.read(databaseProvider);
    final showAll = ref.watch(showAllCountItemsProvider);
    
    // Fetch existing drafts
    final drafts = await db.select(db.countDrafts).get();
    final draftMap = {for (var d in drafts) d.productId: d.actualQuantity};
    final draftedProductIds = draftMap.keys.toList();

    // Fetch products
    final query = db.select(db.products);
    
    // Combine filters: Must be active AND (Stock > 0 OR have a draft)
    query.where((p) {
      final active = p.isActive.equals(true);
      if (showAll) return active;
      return active & (p.currentStock.isBiggerThanValue(0) | p.id.isIn(draftedProductIds));
    });
    
    query.orderBy([(p) => drift.OrderingTerm(expression: p.category)]);
    final products = await query.get();

    return products.map((p) => CountItemEntry(
      product: p,
      expectedQuantity: p.currentStock,
      actualQuantity: draftMap[p.id] ?? p.currentStock,
    )).toList();
  }

  Future<void> updateQuantity(String productId, double actual) async {
    final currentItems = state.value ?? [];
    
    state = AsyncData(currentItems.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(actualQuantity: actual);
      }
      return item;
    }).toList());

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
      await db.transaction(() async {
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

        await db.delete(db.countDrafts).go();
      });

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
