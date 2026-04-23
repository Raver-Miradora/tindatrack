import 'package:flutter/material.dart';
import '../../../core/database/database.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
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

    if (suggestions.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('${product.category} | ${product.unit}'),
          onTap: () => close(context, product),
        );
      },
    );
  }
}
