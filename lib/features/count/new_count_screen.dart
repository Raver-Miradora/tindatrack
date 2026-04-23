import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'count_controller.dart';
import '../../core/logic/haptics.dart';
import '../../core/widgets/async_value_widget.dart';

class NewCountScreen extends ConsumerStatefulWidget {
  const NewCountScreen({super.key});

  @override
  ConsumerState<NewCountScreen> createState() => _NewCountScreenState();
}

class _NewCountScreenState extends ConsumerState<NewCountScreen> {
  String _searchQuery = '';
  bool _showOnlyDiscrepancies = false;

  @override
  Widget build(BuildContext context) {
    final groupedItemsAsync = ref.watch(groupedCountItemsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Physical Count', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear Drafts',
            onPressed: () => _confirmClearDrafts(context, ref),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              onPressed: () => _confirmFinalize(context, ref),
              icon: const Icon(Icons.done_all, color: Colors.green, size: 20),
              label: const Text('Finalize', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: AsyncValueWidget(
              value: groupedItemsAsync,
              data: (groups) {
                final filteredGroups = _filterGroups(groups);
                if (filteredGroups.isEmpty) {
                  return _buildNoResultsState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: filteredGroups.keys.length,
                  itemBuilder: (context, index) {
                    final category = filteredGroups.keys.elementAt(index);
                    final items = filteredGroups[category]!;
                    return _buildCategorySection(context, ref, category, items);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, size: 20),
              hintText: 'Search products or categories...',
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              FilterChip(
                label: const Text('Show Only Discrepancies', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                selected: _showOnlyDiscrepancies,
                onSelected: (val) {
                  TindaHaptics.selection();
                  setState(() => _showOnlyDiscrepancies = val);
                },
                selectedColor: Colors.red.shade50,
                checkmarkColor: Colors.red,
                side: BorderSide(color: _showOnlyDiscrepancies ? Colors.red.shade200 : Colors.grey.shade300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, List<CountItemEntry>> _filterGroups(Map<String, List<CountItemEntry>> groups) {
    final Map<String, List<CountItemEntry>> filtered = {};
    for (final entry in groups.entries) {
      final category = entry.key;
      final items = entry.value;

      final filteredItems = items.where((item) {
        final matchesSearch = item.product.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                              category.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesDiscrepancy = !_showOnlyDiscrepancies || item.variance != 0;
        return matchesSearch && matchesDiscrepancy;
      }).toList();

      if (filteredItems.isNotEmpty) {
        filtered[category] = filteredItems;
      }
    }
    return filtered;
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          Text(_searchQuery.isEmpty ? 'No products in store' : 'No matching results', style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, WidgetRef ref, String category, List<CountItemEntry> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 24, bottom: 8),
          child: Text(
            category.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.5, color: Colors.black54),
          ),
        ),
        ...items.map((item) => _buildCountItem(context, ref, item)),
      ],
    );
  }

  Widget _buildCountItem(BuildContext context, WidgetRef ref, CountItemEntry item) {
    final hasVariance = item.variance != 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: hasVariance ? (item.variance > 0 ? Colors.orange.shade200 : Colors.red.shade200) : Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 5)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  'Expected: ${item.expectedQuantity.toInt()} ${item.product.unit}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (hasVariance)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: item.variance > 0 ? Colors.orange.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${item.variance > 0 ? "-" : "+"}${item.variance.abs().toInt()}',
                style: TextStyle(
                  color: item.variance > 0 ? Colors.orange.shade900 : Colors.red.shade900,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
          SizedBox(
            width: 70,
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onTap: () {
                TindaHaptics.light();
              },
              onSubmitted: (val) {
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
    TindaHaptics.selection();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Finalize Reconciliation', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('This will sync your system stock with physical reality. All recorded variances will be logged.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Review Again')),
          ElevatedButton(
            onPressed: () async {
              TindaHaptics.success();
              Navigator.pop(context);
              final success = await ref.read(countSessionNotifierProvider.notifier).finalizeCount();
              if (context.mounted) {
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Inventory Reconciled! ✨')));
                  context.pop();
                } else {
                  TindaHaptics.warning();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error reconciling inventory'), backgroundColor: Colors.red));
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Confirm & Sync'),
          ),
        ],
      ),
    );
  }

  void _confirmClearDrafts(BuildContext context, WidgetRef ref) {
    TindaHaptics.warning();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Reset All Drafts?'),
        content: const Text('This will clear all your inputs and reset items to their expected values.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Keep Drafts')),
          TextButton(
            onPressed: () {
              TindaHaptics.success();
              ref.read(countSessionNotifierProvider.notifier).clearAllDrafts();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset Everything'),
          ),
        ],
      ),
    );
  }
}
