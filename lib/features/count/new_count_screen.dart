import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'count_controller.dart';

class NewCountScreen extends ConsumerWidget {
  const NewCountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedItemsAsync = ref.watch(groupedCountItemsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Physical Count'),
        actions: [
          TextButton.icon(
            onPressed: () => _confirmFinalize(context, ref),
            icon: const Icon(Icons.done_all, color: Colors.green),
            label: const Text('Finalize', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: groupedItemsAsync.when(
        data: (groups) => ListView.builder(
          itemCount: groups.keys.length,
          itemBuilder: (context, index) {
            final category = groups.keys.elementAt(index);
            final items = groups[category]!;
            return _buildCategorySection(context, ref, category, items);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, WidgetRef ref, String category, List<CountItemEntry> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.grey.shade200,
          child: Text(
            category.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2, color: Colors.black54),
          ),
        ),
        ...items.map((item) => _buildCountItem(context, ref, item)),
      ],
    );
  }

  Widget _buildCountItem(BuildContext context, WidgetRef ref, CountItemEntry item) {
    final hasVariance = item.variance != 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  'Expected: ${item.expectedQuantity.toInt()} ${item.product.unit}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          if (hasVariance)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: item.variance > 0 ? Colors.orange.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${item.variance > 0 ? "-" : "+"}${item.variance.abs().toInt()}',
                style: TextStyle(
                  color: item.variance > 0 ? Colors.orange.shade900 : Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: '${item.expectedQuantity.toInt()}',
              ),
              onChanged: (val) {
                final newValue = double.tryParse(val) ?? item.expectedQuantity;
                ref.read(countSessionNotifierProvider.notifier).updateQuantity(item.product.id, newValue);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmFinalize(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finalize Count'),
        content: const Text('This will reset your system stock to match these physical counts. Continue?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref.read(countSessionNotifierProvider.notifier).finalizeCount();
              if (context.mounted) {
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Inventory reconciled successfully!')));
                  context.pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error finalizing count.'), backgroundColor: Colors.red));
                }
              }
            },
            child: const Text('Finalize'),
          ),
        ],
      ),
    );
  }
}
