import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';

/// Sentinel ID used to identify misc/open-amount cart entries.
/// These items skip the stock-deduction query at checkout.
const kMiscItemId = 'misc_open_item';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  /// Factory for creating a one-off miscellaneous cash item.
  factory CartItem.misc(double amount) {
    final now = DateTime.now();
    return CartItem(
      product: Product(
        id: kMiscItemId,
        barcode: null,
        name: 'Miscellaneous',
        category: 'Other',
        unit: 'pcs',
        reorderPoint: 0,
        averageCost: 0,
        averageSellingPrice: amount,
        burnRatePerDay: 0,
        lastActualQuantity: 0,
        currentStock: 0,
        lastCountedAt: null,
        lastBurnRateUpdate: null,
        isActive: true,
        isSeeded: false,
        createdAt: now,
        updatedAt: now,
      ),
      quantity: 1,
    );
  }

  bool get isMisc => product.id == kMiscItemId;

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get total => (product.averageSellingPrice ?? 0) * quantity;
}

class PosCartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addScannedProduct(Product product) {
    // Misc items are never merged with scanned products
    final existingIndex =
        state.indexWhere((item) => !item.isMisc && item.product.id == product.id);
    if (existingIndex >= 0) {
      final updated = List<CartItem>.from(state);
      updated[existingIndex] = updated[existingIndex].copyWith(
        quantity: updated[existingIndex].quantity + 1,
      );
      state = updated;
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  /// Adds an open-amount miscellaneous line item (e.g., loose tingi spices).
  /// Each call always creates a fresh entry — misc items are never merged.
  void addMiscItem(double amount) {
    if (amount <= 0) return;
    state = [...state, CartItem.misc(amount)];
  }

  void increment(String productId) {
    state = state.map((item) {
      if (item.product.id == productId && !item.isMisc) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
  }

  void decrement(String productId) {
    state = state.map((item) {
      if (item.product.id == productId && item.quantity > 1 && !item.isMisc) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
  }

  void remove(String productId) {
    // For misc items, remove only the LAST occurrence to avoid wiping all misc lines
    if (productId == kMiscItemId) {
      final lastIndex =
          state.lastIndexWhere((item) => item.product.id == kMiscItemId);
      if (lastIndex >= 0) {
        final updated = List<CartItem>.from(state)..removeAt(lastIndex);
        state = updated;
      }
      return;
    }
    state = state.where((item) => item.product.id != productId).toList();
  }

  void clearCart() => state = [];

  Future<bool> finalizeSale({String paymentMethod = 'CASH', String? customerId}) async {
    if (state.isEmpty) return false;

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final grandTotal = state.fold(0.0, (sum, item) => sum + item.total);

    // Build human-readable snapshot: "2x Coke, 1x Tuna, Misc PHP 5.00"
    final itemsSnapshot = state.map((item) {
      if (item.isMisc) {
        return 'Misc PHP ${(item.product.averageSellingPrice ?? 0).toStringAsFixed(2)}';
      }
      return '${item.quantity}x ${item.product.name}';
    }).join(', ');

    try {
      await db.transaction(() async {
        await db.batch((batch) {
          for (final item in state) {
            // ── CRITICAL GUARD: Skip stock deduction for misc items ──────────
            if (item.isMisc) continue;

            batch.customStatement(
              'UPDATE products SET current_stock = current_stock - ?, updated_at = ? WHERE id = ?',
              [item.quantity.toDouble(), now.millisecondsSinceEpoch ~/ 1000, item.product.id],
            );
          }

          // Insert into SalesTransactions ledger (includes misc totals)
          batch.insert(
            db.salesTransactions,
            SalesTransactionsCompanion.insert(
              timestamp: drift.Value(now),
              totalAmount: grandTotal,
              itemsSnapshot: itemsSnapshot,
              paymentMethod: drift.Value(paymentMethod),
            ),
          );

          if (paymentMethod == 'CREDIT' && customerId != null) {
            batch.insert(
              db.utangLedger,
              UtangLedgerCompanion.insert(
                id: const Uuid().v4(),
                customerId: customerId,
                amount: grandTotal,
                timestamp: drift.Value(now),
                description: const drift.Value('Utang (POS Sale)'),
                itemsSnapshot: drift.Value(itemsSnapshot),
              ),
            );
          }

          // Log the POS Sale in AuditLog
          batch.insert(
            db.auditLog,
            AuditLogCompanion.insert(
              id: const Uuid().v4(),
              actionType: 'pos_sale',
              targetType: 'system',
              targetId: 'pos',
              afterSnapshot: drift.Value(jsonEncode({
                "itemsCount": state.length,
                "totalSales": grandTotal,
              })),
              timestamp: drift.Value(now),
            ),
          );
        });
      });
      clearCart();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final posCartProvider =
    NotifierProvider.autoDispose<PosCartNotifier, List<CartItem>>(
        PosCartNotifier.new);

final posCartTotalProvider = Provider.autoDispose<double>((ref) {
  final cart = ref.watch(posCartProvider);
  return cart.fold(0, (sum, item) => sum + item.total);
});
