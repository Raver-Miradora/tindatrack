import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'delivery_controller.dart';
import 'widgets/scanner_view.dart';
import 'widgets/item_edit_dialog.dart';
import 'widgets/product_search_delegate.dart';
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

class NewDeliveryScreen extends ConsumerWidget {
  const NewDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(deliveryCartProvider);
    final cart = cartState.items;
    final totalCost = cartState.totalValue;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('New Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
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
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return _buildCartItem(context, ref, item);
                    },
                  ),
          ),
          _buildSummaryFooter(context, ref, cart.length, totalCost),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('Your cart is empty', style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Scan a barcode or search to add items', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, WidgetRef ref, DeliveryCartItem item) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('Cost: PHP ${item.unitCost.toStringAsFixed(2)} per ${item.product.unit}'),
              Text('Subtotal: PHP ${(item.quantity * item.unitCost).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Text('${item.quantity.toInt()} ${item.product.unit}', style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold)),
          ),
          onTap: () => _editItem(context, ref, item),
        ),
      ),
    );
  }

  Widget _buildSummaryFooter(BuildContext context, WidgetRef ref, int itemCount, double totalCost) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Delivery Summary', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(
                      'PHP ${totalCost.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: itemCount == 0 ? null : () => _saveDelivery(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Save Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openScanner(BuildContext context, WidgetRef ref) async {
    TindaHaptics.selection();
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const ScannerView()),
    );
    if (result != null) {
      final found = await ref.read(deliveryCartProvider.notifier).addProductByBarcode(result);
      if (!found && context.mounted) {
        TindaHaptics.warning();
        _promptCreateProduct(context, ref, result);
      }
    }
  }

  void _promptCreateProduct(BuildContext context, WidgetRef ref, String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product Not Found'),
        content: Text('The barcode "$barcode" is not in your inventory. Would you like to create it now?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Maybe Later')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final newProduct = await context.push<Product?>('/inventory/create', extra: barcode);
              if (newProduct != null) {
                ref.read(deliveryCartProvider.notifier).addProduct(newProduct);
              }
            },
            child: const Text('Create Now'),
          ),
        ],
      ),
    );
  }

  void _openSearch(BuildContext context, WidgetRef ref) async {
    TindaHaptics.selection();
    final db = ref.read(databaseProvider);
    final products = await db.select(db.products).get();
    
    if (context.mounted) {
      final result = await showSearch<dynamic>(
        context: context,
        delegate: ProductSearchDelegate(products),
      );
      
      if (result is Product) {
        ref.read(deliveryCartProvider.notifier).addProduct(result);
      }
    }
  }

  void _editItem(BuildContext context, WidgetRef ref, DeliveryCartItem item) async {
    TindaHaptics.light();
    showDialog(
      context: context,
      builder: (context) => ItemEditDialog(
        item: item,
        onConfirm: (qty, cost) {
          ref.read(deliveryCartProvider.notifier).updateQuantity(item.product.id, qty);
          ref.read(deliveryCartProvider.notifier).updateUnitCost(item.product.id, cost);
        },
        onRemove: () {
          ref.read(deliveryCartProvider.notifier).removeItem(item.product.id);
        },
      ),
    );
  }

  void _saveDelivery(BuildContext context, WidgetRef ref) async {
    TindaHaptics.success();
    final success = await ref.read(deliveryCartProvider.notifier).saveDelivery();
    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delivery saved successfully!')));
        context.pop();
      } else {
        TindaHaptics.warning();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error saving delivery'), backgroundColor: Colors.red));
      }
    }
  }
}
