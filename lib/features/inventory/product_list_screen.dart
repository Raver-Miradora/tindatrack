import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/database/database.dart';
import '../../core/logic/haptics.dart';
import '../../core/widgets/async_value_widget.dart';
import '../dashboard/dashboard_providers.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  final bool initialShowLowStock;
  const ProductListScreen({super.key, this.initialShowLowStock = false});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  String _searchQuery = '';
  bool _showOnlyInStock = true;
  bool _showOnlyLowStock = false;
  bool _showNewOnly = false;

  @override
  void initState() {
    super.initState();
    _showOnlyLowStock = widget.initialShowLowStock;
    // Removed override: keep 'In-Store Only' true when 'Low Stock' is true 
    // to filter out seeded items that have 0 stock and have never been stocked.
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Store Products', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search inventory...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('In-Store Only', style: TextStyle(fontSize: 12)),
                      selected: _showOnlyInStock,
                      onSelected: (val) => setState(() => _showOnlyInStock = val),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Low Stock', style: TextStyle(fontSize: 12)),
                      selected: _showOnlyLowStock,
                      selectedColor: Colors.orange.shade100,
                      checkmarkColor: Colors.orange.shade900,
                      onSelected: (val) => setState(() => _showOnlyLowStock = val),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Bagong Paninda', style: TextStyle(fontSize: 12)),
                      selected: _showNewOnly,
                      selectedColor: Colors.purple.shade100,
                      checkmarkColor: Colors.purple.shade900,
                      onSelected: (val) => setState(() => _showNewOnly = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: AsyncValueWidget(
        value: productsAsync,
        data: (products) {
          final filtered = products.where((p) {
            final matchesQuery = p.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                               p.barcode?.contains(_searchQuery) == true;
                               
            if (_showNewOnly) {
              return matchesQuery && !p.isSeeded;
            }
            
            final matchesStock = !_showOnlyInStock || p.currentStock > 0;
            final matchesLowStock = !_showOnlyLowStock || p.currentStock <= p.reorderPoint;
            return matchesQuery && matchesStock && matchesLowStock;
          }).toList();

          if (filtered.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final product = filtered[index];
              return _buildProductCard(context, product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          TindaHaptics.selection();
          context.push('/inventory/create');
        },
        icon: const Icon(Icons.add),
        label: const Text('New Product'),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final hasStock = product.currentStock > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
          child: Icon(hasStock ? Icons.inventory_2 : Icons.inventory_2_outlined, color: hasStock ? Colors.blue : Colors.grey),
        ),
        title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${product.category} • ${product.unit}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              product.currentStock.toInt().toString(),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: hasStock ? Colors.black : Colors.grey),
            ),
            Text('STOCK', style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(_searchQuery.isEmpty ? 'No items in stock yet' : 'No matches found for "$_searchQuery"', style: const TextStyle(color: Colors.grey)),
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push('/inventory/create', extra: _searchQuery),
              icon: const Icon(Icons.add),
              label: Text('Add "$_searchQuery"'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
