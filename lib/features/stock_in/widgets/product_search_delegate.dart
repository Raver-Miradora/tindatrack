import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/database.dart';

class ProductSearchDelegate extends SearchDelegate<dynamic> {
  final List<Product> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    final suggestions = products.where((p) {
      final nameLower = p.name.toLowerCase();
      final categoryLower = p.category.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) || categoryLower.contains(queryLower);
    }).toList();

    if (suggestions.isEmpty && query.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('No products found for "$query"', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                final newProduct = await context.push<Product?>('/inventory/create');
                if (context.mounted && newProduct != null) {
                  close(context, newProduct);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Create New Product'),
            ),
          ],
        ),
      );
    }

    if (suggestions.isEmpty) {
      return const Center(child: Text('Start typing to search...'));
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Text(product.name[0].toUpperCase(), style: const TextStyle(fontSize: 12)),
          ),
          title: Text(product.name),
          subtitle: Text('${product.category} | ${product.unit}'),
          onTap: () => close(context, product),
        );
      },
    );
  }
}
