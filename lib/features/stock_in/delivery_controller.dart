import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';

class DeliveryCartItem {
  final Product product;
  final double quantity;
  final double unitCost;

  DeliveryCartItem({
    required this.product,
    this.quantity = 1.0,
    required this.unitCost,
  });

  DeliveryCartItem copyWith({
    Product? product,
    double? quantity,
    double? unitCost,
  }) {
    return DeliveryCartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      unitCost: unitCost ?? this.unitCost,
    );
  }
}

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

  double get totalValue => items.fold(0.0, (sum, item) => sum + (item.quantity * item.unitCost));
}

class DeliveryCartNotifier extends Notifier<DeliveryCartState> {
  @override
  DeliveryCartState build() {
    return DeliveryCartState();
  }

  void setSupplier(String name) {
    state = state.copyWith(supplierName: name);
  }

  void addProduct(Product product) {
    HapticFeedback.lightImpact();
    final existingIndex = state.items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex != -1) {
      final updatedItems = List<DeliveryCartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          DeliveryCartItem(product: product, unitCost: product.averageCost),
        ],
      );
    }
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
    HapticFeedback.mediumImpact();
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

      // OPTIMIZATION: Fetch all affected products in ONE query before transaction
      final productIds = state.items.map((i) => i.product.id).toList();
      final productsList = await (db.select(db.products)..where((p) => p.id.isIn(productIds))).get();
      final productMap = {for (var p in productsList) p.id: p};

      await db.transaction(() async {
        // 1. Create the StockInEvent
        await db.into(db.stockInEvents).insert(
          StockInEventsCompanion.insert(
            id: eventId,
            supplierName: state.supplierName.isEmpty ? 'General Supplier' : state.supplierName,
            deliveryDate: now,
            createdAt: drift.Value(now),
          ),
        );

        // 2. Create StockInItems & Update Product Baseline Stock
        for (final item in state.items) {
          final currentProduct = productMap[item.product.id];
          if (currentProduct == null) continue;

          await db.into(db.stockInItems).insert(
            StockInItemsCompanion.insert(
              id: const Uuid().v4(),
              stockInEventId: eventId,
              productId: item.product.id,
              quantity: item.quantity,
              unitCost: item.unitCost,
            ),
          );

          // Update product's baseline stock (currentStock) and average cost
          await (db.update(db.products)..where((p) => p.id.equals(item.product.id)))
            .write(ProductsCompanion(
              averageCost: drift.Value(item.unitCost),
              currentStock: drift.Value(currentProduct.currentStock + item.quantity),
              updatedAt: drift.Value(now),
            ));
          
          // 3. Log to Audit Log with Before/After snapshots
          await db.into(db.auditLog).insert(
            AuditLogCompanion.insert(
              id: const Uuid().v4(),
              actionType: 'Stock In (Delivery)',
              targetType: 'product',
              targetId: item.product.id,
              beforeSnapshot: drift.Value(jsonEncode({
                "estimated_stock": currentProduct.currentStock,
                "average_cost": currentProduct.averageCost,
              })),
              afterSnapshot: drift.Value(jsonEncode({
                "quantity_added": item.quantity,
                "new_estimated_stock": currentProduct.currentStock + item.quantity,
                "unit_cost": item.unitCost,
                "supplier": state.supplierName,
              })),
              timestamp: drift.Value(now),
            ),
          );
        }
      });

      state = DeliveryCartState(); // Reset
      HapticFeedback.heavyImpact();
      return true;
    } catch (e) {
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}

final deliveryCartProvider = NotifierProvider<DeliveryCartNotifier, DeliveryCartState>(DeliveryCartNotifier.new);
