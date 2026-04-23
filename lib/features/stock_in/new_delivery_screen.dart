import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'delivery_controller.dart';
import 'widgets/scanner_view.dart';
import 'widgets/product_search_delegate.dart';
import '../../core/providers.dart';
import '../../core/database/database.dart'; // REQUIRED IMPORT

class NewDeliveryScreen extends ConsumerWidget {
  const NewDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deliveryCartProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('New Delivery'),
        actions: [
          if (state.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton.icon(
                onPressed: state.isSaving ? null : () => _confirmSave(context, ref),
                icon: state.isSaving 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.check_circle_outline, color: Colors.green),
                label: Text(
                  state.isSaving ? 'Saving...' : 'Save', 
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildSupplierHeader(context, ref, state),
          Expanded(
            child: state.items.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return _buildDismissibleItem(context, ref, item);
                    },
                  ),
          ),
          _buildCartSummary(context, state),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.isSaving ? null : () => _showAddOptions(context, ref),
        backgroundColor: state.isSaving ? Colors.grey : theme.primaryColor,
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: const Text('Add Items', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSupplierHeader(BuildContext context, WidgetRef ref, DeliveryCartState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        onChanged: (val) => ref.read(deliveryCartProvider.notifier).setSupplier(val),
        enabled: !state.isSaving,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.business_outlined),
          hintText: 'Supplier Name (Optional)',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('No items added yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 18)),
          const SizedBox(height: 8),
          Text('Tap the button below to scan or search', style: TextStyle(color: Colors.grey.shade400)),
        ],
      ),
    );
  }

  Widget _buildDismissibleItem(BuildContext context, WidgetRef ref, DeliveryCartItem item) {
    return Dismissible(
      key: Key('cart_item_${item.product.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(deliveryCartProvider.notifier).removeItem(item.product.id);
      },
      child: _buildCartItem(context, ref, item),
    );
  }

  Widget _buildCartItem(BuildContext context, WidgetRef ref, DeliveryCartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.shopping_bag_outlined, color: Colors.green),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  InkWell(
                    onTap: () => _showCostEditDialog(context, ref, item),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Unit Cost: PHP ${item.unitCost.toStringAsFixed(2)}', style: TextStyle(color: Colors.blue.shade700, fontSize: 12, decoration: TextDecoration.underline)),
                        const SizedBox(width: 4),
                        Icon(Icons.edit, size: 12, color: Colors.blue.shade700),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildQuantityControls(ref, item),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls(WidgetRef ref, DeliveryCartItem item) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (item.quantity > 1) {
              ref.read(deliveryCartProvider.notifier).updateQuantity(item.product.id, item.quantity - 1);
            } else {
              ref.read(deliveryCartProvider.notifier).removeItem(item.product.id);
            }
          },
          icon: Icon(item.quantity > 1 ? Icons.remove_circle_outline : Icons.delete_outline, color: Colors.grey),
        ),
        Text('${item.quantity.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        IconButton(
          onPressed: () => ref.read(deliveryCartProvider.notifier).updateQuantity(item.product.id, item.quantity + 1),
          icon: const Icon(Icons.add_circle_outline, color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildCartSummary(BuildContext context, DeliveryCartState state) {
    if (state.items.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Total Value', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('PHP ${state.totalValue.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            Text('${state.items.length} unique items', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile(
              context,
              icon: Icons.qr_code_scanner_rounded,
              title: 'Scan Barcode',
              subtitle: 'Use camera to add items',
              color: Colors.blue,
              onTap: () => _handleBarcodeScan(context, ref),
            ),
            const SizedBox(height: 16),
            _buildOptionTile(
              context,
              icon: Icons.search_rounded,
              title: 'Search Product',
              subtitle: 'Find by name or category',
              color: Colors.orange,
              onTap: () async {
                Navigator.pop(context);
                final db = ref.read(databaseProvider);
                final products = await db.select(db.products).get();
                
                if (context.mounted) {
                  final product = await showSearch<Product?>(
                    context: context,
                    delegate: ProductSearchDelegate(products),
                  );
                  if (product != null) {
                    ref.read(deliveryCartProvider.notifier).addProduct(product);
                  }
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBarcodeScan(BuildContext context, WidgetRef ref) async {
    Navigator.pop(context);
    final barcode = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const ScannerView()),
    );
    
    if (barcode != null) {
      final db = ref.read(databaseProvider);
      final product = await (db.select(db.products)..where((p) => p.barcode.equals(barcode))).getSingleOrNull();
      
      if (product != null) {
        ref.read(deliveryCartProvider.notifier).addProduct(product);
      } else {
        if (context.mounted) {
          _showProductNotFoundDialog(context, barcode);
        }
      }
    }
  }

  void _showProductNotFoundDialog(BuildContext context, String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product Not Found'),
        content: Text('The barcode "$barcode" is not in your inventory. Would you like to add it now?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Dismiss')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigate to "Create Product" (Coming Soon)')));
            },
            child: const Text('Create Product'),
          ),
        ],
      ),
    );
  }

  void _showCostEditDialog(BuildContext context, WidgetRef ref, DeliveryCartItem item) {
    final controller = TextEditingController(text: item.unitCost.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Unit Cost: ${item.product.name}'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: const InputDecoration(prefixText: 'PHP ', labelText: 'New Unit Cost'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newCost = double.tryParse(controller.text);
              if (newCost != null) {
                ref.read(deliveryCartProvider.notifier).updateUnitCost(item.product.id, newCost);
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  void _confirmSave(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delivery'),
        content: const Text('This will update your estimated stock and baseline average costs. Proceed?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref.read(deliveryCartProvider.notifier).saveDelivery();
              if (context.mounted) {
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delivery saved successfully!')));
                  context.pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to save delivery.'), backgroundColor: Colors.red));
                }
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
