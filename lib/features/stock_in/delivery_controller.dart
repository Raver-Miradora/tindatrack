import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

// ── Operation Type ────────────────────────────────────────────────────────────

/// Describes HOW a cart item's stock should be applied on commit.
/// - [add]: Delivery — current_stock += quantity, average_cost updated.
/// - [set]: Physical Count — current_stock = quantity (absolute override).
enum InventoryOperation { add, set }

// ── Cart Item ─────────────────────────────────────────────────────────────────

class DeliveryCartItem {
  final Product product;
  final double quantity;
  final double unitCost;
  final double unitSellingPrice;
  final InventoryOperation operation;

  DeliveryCartItem({
    required this.product,
    this.quantity = 1.0,
    required this.unitCost,
    required this.unitSellingPrice,
    this.operation = InventoryOperation.add,
  });

  DeliveryCartItem copyWith({
    Product? product,
    double? quantity,
    double? unitCost,
    double? unitSellingPrice,
    InventoryOperation? operation,
  }) {
    return DeliveryCartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitCost: unitCost ?? this.unitCost,
      unitSellingPrice: unitSellingPrice ?? this.unitSellingPrice,
      operation: operation ?? this.operation,
    );
  }
}

// ── Cart State ────────────────────────────────────────────────────────────────

class DeliveryCartState {
  final List<DeliveryCartItem> items;
  final String supplierName;
  final bool isSaving;

  DeliveryCartState({
    this.items = const [],
    this.supplierName = '',
    this.isSaving = false,
  });

  DeliveryCartState copyWith({
    List<DeliveryCartItem>? items,
    String? supplierName,
    bool? isSaving,
  }) {
    return DeliveryCartState(
      items: items ?? this.items,
      supplierName: supplierName ?? this.supplierName,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  /// Total delivery cost — only counts items with operation == add
  /// (set items don't represent a purchase value).
  double get totalValue => items
      .where((i) => i.operation == InventoryOperation.add)
      .fold(0.0, (sum, item) => sum + (item.quantity * item.unitCost));
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class DeliveryCartNotifier extends Notifier<DeliveryCartState> {
  @override
  DeliveryCartState build() {
    // LIFECYCLE FIX: keepAlive prevents Riverpod from disposing this provider
    // when the widget tree rebuilds (e.g. user receives a phone call and the
    // app goes to background). Without this, the cart is silently wiped when
    // the app resumes, losing all unsaved delivery data.
    ref.keepAlive();
    return DeliveryCartState();
  }

  void setSupplier(String name) {
    state = state.copyWith(supplierName: name);
  }

  /// Legacy convenience method — adds a product as a Delivery (add) with qty=1.
  void addProduct(Product product) {
    addItem(
      product: product,
      quantity: 1.0,
      unitCost: product.averageCost,
      unitSellingPrice: product.averageSellingPrice ?? 0.0,
      operation: InventoryOperation.add,
    );
  }

  /// Primary API for adding or updating a cart item with a specific operation.
  /// Replaces the item entirely if it already exists (same product).
  void addItem({
    required Product product,
    required double quantity,
    required double unitCost,
    required double unitSellingPrice,
    required InventoryOperation operation,
  }) {
    TindaHaptics.light();
    final existingIndex =
        state.items.indexWhere((item) => item.product.id == product.id);
    final newItem = DeliveryCartItem(
      product: product,
      quantity: quantity,
      unitCost: unitCost,
      unitSellingPrice: unitSellingPrice,
      operation: operation,
    );
    if (existingIndex != -1) {
      // Replace the existing entry with the new values + new operation type
      final updatedItems = List<DeliveryCartItem>.from(state.items);
      updatedItems[existingIndex] = newItem;
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(items: [...state.items, newItem]);
    }
  }

  void updateUnitSellingPrice(String productId, double price) {
    state = state.copyWith(
      items: state.items.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(unitSellingPrice: price.roundToDouble());
        }
        return item;
      }).toList(),
    );
  }

  void updateQuantity(String productId, double quantity) {
    state = state.copyWith(
      items: state.items.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList(),
    );
  }

  void updateUnitCost(String productId, double cost) {
    state = state.copyWith(
      items: state.items.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(unitCost: cost);
        }
        return item;
      }).toList(),
    );
  }

  void removeItem(String productId) {
    TindaHaptics.selection();
    state = state.copyWith(
      items: state.items.where((item) => item.product.id != productId).toList(),
    );
  }

  void clearCart() {
    state = DeliveryCartState();
  }

  Future<bool> saveDelivery() async {
    if (state.isSaving || state.items.isEmpty) return false;

    final db = ref.read(databaseProvider);
    state = state.copyWith(isSaving: true);

    try {
      final eventId = const Uuid().v4();
      final now = DateTime.now();
      final supplier =
          state.supplierName.isEmpty ? 'General Supplier' : state.supplierName;

      final productIds = state.items.map((i) => i.product.id).toList();
      final productsList = await (db.select(db.products)
            ..where((p) => p.id.isIn(productIds)))
          .get();
      final productMap = {for (var p in productsList) p.id: p};

      final deliveryItems =
          state.items.where((i) => i.operation == InventoryOperation.add).toList();
      final countItems =
          state.items.where((i) => i.operation == InventoryOperation.set).toList();

      await db.transaction(() async {
        // ── DELIVERY ITEMS ─────────────────────────────────────────────────
        if (deliveryItems.isNotEmpty) {
          // 1. Create the StockInEvent (only if we have delivery items)
          await db.into(db.stockInEvents).insert(
            StockInEventsCompanion.insert(
              id: eventId,
              supplierName: supplier,
              deliveryDate: now,
              createdAt: drift.Value(now),
            ),
          );

          for (final item in deliveryItems) {
            final currentProduct = productMap[item.product.id];
            if (currentProduct == null) continue;

            // 2a. Log line item in StockInItems ledger
            await db.into(db.stockInItems).insert(
              StockInItemsCompanion.insert(
                id: const Uuid().v4(),
                stockInEventId: eventId,
                productId: item.product.id,
                quantity: item.quantity,
                unitCost: item.unitCost,
              ),
            );

            // 2b. Update product: add qty + update costs
            await (db.update(db.products)
                  ..where((p) => p.id.equals(item.product.id)))
                .write(ProductsCompanion(
              averageCost: drift.Value(item.unitCost),
              averageSellingPrice: drift.Value(item.unitSellingPrice),
              currentStock: drift.Value(
                  currentProduct.currentStock + item.quantity),
              updatedAt: drift.Value(now),
            ));
          }
        }

        // ── COUNT (SET) ITEMS ──────────────────────────────────────────────
        if (countItems.isNotEmpty) {
          // Create a count session to preserve audit history
          final countSessionId = const Uuid().v4();
          await db.into(db.countSessions).insert(
            CountSessionsCompanion.insert(
              id: countSessionId,
              countType: 'spot',
              startedAt: drift.Value(now),
              completedAt: drift.Value(now),
            ),
          );

          for (final item in countItems) {
            final currentProduct = productMap[item.product.id];
            if (currentProduct == null) continue;

            // Log in CountItems for audit trail
            await db.into(db.countItems).insert(
              CountItemsCompanion.insert(
                id: const Uuid().v4(),
                countSessionId: countSessionId,
                productId: item.product.id,
                expectedQuantity: currentProduct.currentStock,
                actualQuantity: item.quantity,
                variance: item.quantity - currentProduct.currentStock,
                countedAt: drift.Value(now),
              ),
            );

            // Set absolute stock override
            await (db.update(db.products)
                  ..where((p) => p.id.equals(item.product.id)))
                .write(ProductsCompanion(
              currentStock: drift.Value(item.quantity),
              lastActualQuantity: drift.Value(item.quantity),
              lastCountedAt: drift.Value(now),
              updatedAt: drift.Value(now),
            ));
          }
        }

        // ── AUDIT LOG ─────────────────────────────────────────────────────
        await db.into(db.auditLog).insert(
          AuditLogCompanion.insert(
            id: const Uuid().v4(),
            actionType: 'Inventory Update',
            targetType: 'StockInEvent',
            targetId: eventId,
            afterSnapshot: drift.Value(jsonEncode({
              "supplier": supplier,
              "deliveryItems": deliveryItems.length,
              "countItems": countItems.length,
              "totalDeliveryValue": state.totalValue,
            })),
            timestamp: drift.Value(now),
          ),
        );
      });

      state = DeliveryCartState();
      TindaHaptics.success();
      return true;
    } catch (e) {
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}

final deliveryCartProvider =
    NotifierProvider<DeliveryCartNotifier, DeliveryCartState>(
        DeliveryCartNotifier.new);
