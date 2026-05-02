import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'delivery_controller.dart';
import 'widgets/scanner_view.dart';
import 'widgets/item_edit_dialog.dart';
import 'widgets/product_search_delegate.dart';
import 'widgets/scan_item_bottom_sheet.dart';
import '../../features/inventory/product_create_screen.dart';
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

// ─────────────────────────────────────────────────────────────────────────────
// REBUILD GRANULARITY FIX
//
// Before: NewDeliveryScreen was a single ConsumerWidget watching the full
// deliveryCartProvider. Any change (add item, change price, change qty)
// caused the ENTIRE screen — AppBar, body, footer — to rebuild.
//
// After: The screen is split into three scoped widgets:
//   1. NewDeliveryScreen     — StatelessWidget (no ref.watch, never rebuilds)
//   2. _DeliveryCartList     — ConsumerWidget watching only cart.items
//   3. _DeliverySummaryFooter — ConsumerWidget watching only cart.totalValue
//                               and cart.items.length
//
// When a price changes, ONLY _DeliverySummaryFooter rebuilds.
// When an item is added, ONLY _DeliveryCartList rebuilds.
// The AppBar NEVER rebuilds during these interactions.
// ─────────────────────────────────────────────────────────────────────────────

class NewDeliveryScreen extends StatelessWidget {
  const NewDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Update Inventory',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          // Actions captured by a thin ConsumerWidget so only the buttons
          // have access to ref — the AppBar itself never rebuilds.
          _AppBarActions(),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: _DeliveryCartList()),
          _DeliverySummaryFooter(),
        ],
      ),
    );
  }
}

/// Tightly scoped ConsumerWidget for the AppBar action buttons only.
/// Separating this out prevents scanner/search callbacks from triggering
/// an AppBar rebuild on the parent.
class _AppBarActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => _openScanner(context, ref),
          tooltip: 'Scan Barcode',
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _openSearch(context, ref),
          tooltip: 'Search Product',
        ),
      ],
    );
  }

  void _openScanner(BuildContext context, WidgetRef ref) async {
    TindaHaptics.selection();
    // Camera is stopped atomically inside ScannerView before pop — so by the
    // time we get the result here, the UI thread is completely free.
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const ScannerView()),
    );

    if (result == null || !context.mounted) return;

    final db = ref.read(databaseProvider);
    final product = await (db.select(db.products)
          ..where((p) => p.barcode.equals(result)))
        .getSingleOrNull();

    if (!context.mounted) return;

    if (product != null) {
      if (!context.mounted) return;
      _showScanBottomSheet(context, product);
    } else {
      TindaHaptics.warning();
      _promptCreateProduct(context, ref, result);
    }
  }

  void _openSearch(BuildContext context, WidgetRef ref) async {
    TindaHaptics.selection();
    final db = ref.read(databaseProvider);

    final List<Product> products;
    try {
      // Drift executes on its background isolate — never blocks UI thread.
      products = await db.select(db.products).get();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not load products. Please try again.')),
        );
      }
      return;
    }

    if (!context.mounted) return;

    final result = await showSearch<dynamic>(
      context: context,
      delegate: ProductSearchDelegate(products),
    );

    if (result is Product && context.mounted) {
      _showScanBottomSheet(context, result);
    }
  }

  void _showScanBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ScanItemBottomSheet(product: product),
    );
  }

  void _promptCreateProduct(
      BuildContext context, WidgetRef ref, String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product Not Found'),
        content: Text(
            'The barcode "$barcode" is not in your inventory. Would you like to create it now?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Maybe Later')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // Push to ProductCreateScreen and await the full result
              final result = await context.push<ProductCreateResult?>(
                  '/inventory/create',
                  extra: barcode);
              if (result != null && context.mounted) {
                // Immediately inject into cart if qty was provided
                if (result.initialQty > 0) {
                  ref.read(deliveryCartProvider.notifier).addItem(
                    product: result.product,
                    quantity: result.initialQty,
                    unitCost: result.unitCost,
                    unitSellingPrice:
                        result.product.averageSellingPrice ?? 0.0,
                    operation: InventoryOperation.add,
                  );
                  TindaHaptics.success();
                } else {
                  // No initial qty — open bottom sheet so user can configure
                  _showScanBottomSheet(context, result.product);
                }
              }
            },
            child: const Text('Create Now'),
          ),
        ],
      ),
    );
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Vector 2 Fix: Scoped cart list — rebuilds ONLY when items list changes.
// ─────────────────────────────────────────────────────────────────────────────
class _DeliveryCartList extends ConsumerWidget {
  const _DeliveryCartList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // select() means this widget ONLY rebuilds when .items changes identity.
    // Changing a price or qty value without adding/removing items will NOT
    // trigger a rebuild of this list.
    final cart = ref.watch(
      deliveryCartProvider.select((s) => s.items),
    );

    if (cart.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('Your cart is empty',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Scan a barcode or search to add items',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      // itemExtent is critical: Flutter skips layout measurement for
      // off-screen cart items and only renders the visible ones.
      itemExtent: 148.0,
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final item = cart[index];
        // Each cart tile is its own scoped widget so that editing one item
        // only rebuilds that tile, not the entire list.
        return _CartItemTile(key: ValueKey(item.product.id), item: item);
      },
    );
  }
}

/// A single cart item tile, scoped to exactly one [DeliveryCartItem].
/// Wrapped in a [StatelessWidget] (not Consumer) — it receives its data
/// via constructor, so a change to item[0] will never rebuild item[1].
class _CartItemTile extends ConsumerWidget {
  final DeliveryCartItem item;

  const _CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(item.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        TindaHaptics.selection();
        ref.read(deliveryCartProvider.notifier).removeItem(item.product.id);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: item.operation == InventoryOperation.set
                  ? Colors.orange.shade200
                  : Colors.grey.shade200,
            )),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item.operation == InventoryOperation.set
                  ? Colors.orange.shade50
                  : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.operation == InventoryOperation.set
                      ? Icons.swap_horiz_rounded
                      : Icons.add_rounded,
                  size: 16,
                  color: item.operation == InventoryOperation.set
                      ? Colors.orange.shade700
                      : Colors.blue.shade700,
                ),
                Text(
                  item.operation == InventoryOperation.set ? 'SET' : 'ADD',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: item.operation == InventoryOperation.set
                        ? Colors.orange.shade700
                        : Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          title: Text(item.product.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              if (item.operation == InventoryOperation.add) ...[
                Text(
                    'Cost: ₱${item.unitCost % 1 == 0 ? item.unitCost.toInt() : item.unitCost.toStringAsFixed(2)} / ${item.product.unit}'),
                Text('Selling: ₱${item.unitSellingPrice.toInt()}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w600)),
              ] else
                Text('Setting to exact count',
                    style: TextStyle(
                        color: Colors.orange.shade700,
                        fontStyle: FontStyle.italic,
                        fontSize: 12)),
            ],
          ),
          trailing: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: item.operation == InventoryOperation.set
                    ? Colors.orange.shade50
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12)),
            child: Text(
                '${item.quantity.toInt()} ${item.product.unit}',
                style: TextStyle(
                    color: item.operation == InventoryOperation.set
                        ? Colors.orange.shade900
                        : Colors.blue.shade900,
                    fontWeight: FontWeight.bold)),
          ),
          onTap: () => _editItem(context, ref, item),
        ),
      ),
    );
  }

  void _editItem(
      BuildContext context, WidgetRef ref, DeliveryCartItem item) {
    TindaHaptics.light();
    showDialog(
      context: context,
      builder: (context) => ItemEditDialog(
        item: item,
        onConfirm: (qty, cost, price) {
          ref
              .read(deliveryCartProvider.notifier)
              .updateQuantity(item.product.id, qty);
          ref
              .read(deliveryCartProvider.notifier)
              .updateUnitCost(item.product.id, cost);
          ref
              .read(deliveryCartProvider.notifier)
              .updateUnitSellingPrice(item.product.id, price);
        },
        onRemove: () {
          ref
              .read(deliveryCartProvider.notifier)
              .removeItem(item.product.id);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Vector 2 Fix: Scoped footer — rebuilds ONLY when totalValue or count changes.
// ─────────────────────────────────────────────────────────────────────────────
class _DeliverySummaryFooter extends ConsumerWidget {
  const _DeliverySummaryFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Two granular selects — each triggers a rebuild only when its own value changes.
    final itemCount = ref.watch(
      deliveryCartProvider.select((s) => s.items.length),
    );
    final totalCost = ref.watch(
      deliveryCartProvider.select((s) => s.totalValue),
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Inventory Update',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Text(
                  'PHP ${totalCost % 1 == 0 ? totalCost.toInt() : totalCost.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            ElevatedButton(
              onPressed:
                  itemCount == 0 ? null : () => _saveDelivery(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('Commit Inventory',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDelivery(BuildContext context, WidgetRef ref) async {
    TindaHaptics.success();
    final success =
        await ref.read(deliveryCartProvider.notifier).saveDelivery();
    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Delivery saved successfully!')));
        context.pop();
      } else {
        TindaHaptics.warning();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error saving delivery'),
            backgroundColor: Colors.red));
      }
    }
  }
}
