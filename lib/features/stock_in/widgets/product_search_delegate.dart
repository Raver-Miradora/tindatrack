import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/database.dart';

/// A high-performance search delegate with two-layer performance protection:
///
/// Layer 1 — Data cache:
///   The synchronous .where() filter only runs when the query string changes.
///   Identical queries are returned from _cachedResults instantly.
///
/// Layer 2 — UI debounce (the fix for render thrashing):
///   Flutter's SearchDelegate calls buildSuggestions() on EVERY keystroke.
///   Without a debounce gate, typing "Coke" rapidly fires 4 full list renders
///   in a single frame burst, causing visible stutter on low-end devices.
///   A 280ms Timer ensures the ListView only rebuilds once the user pauses.
class ProductSearchDelegate extends SearchDelegate<dynamic> {
  final List<Product> products;

  // ── Layer 1: Data cache ────────────────────────────────────────────────────
  List<Product> _cachedResults = [];
  String _lastQuery = '';

  // ── Layer 2: UI debounce ───────────────────────────────────────────────────
  // The timer delays the visible render by 280ms after the last keystroke.
  // The filter computation itself is instant (<1ms), but this prevents Flutter
  // from scheduling 5 separate rasterizer passes for 5 rapid keystrokes.
  Timer? _debounce;

  // The query value that has been committed to the UI after debounce settles.
  // Starts as a sentinel so the first render always triggers correctly.
  String _debouncedQuery = '\x00';

  ProductSearchDelegate(this.products);

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
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
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    // Wrap in StatefulBuilder to capture a localized setState.
    // SearchDelegate's showSuggestions() does NOT force a rebuild if already
    // showing suggestions, so the Timer needs a real setState to trigger the
    // filter pass once the debounce settles.
    return StatefulBuilder(
      builder: (context, setState) {
        if (query.isEmpty) {
          _debounce?.cancel();
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 64, color: Color(0xFFDDDDDD)),
                SizedBox(height: 12),
                Text('Type to search products…',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        // ── Layer 2: Debounce gate ─────────────────────────────────────────────
        if (query != _debouncedQuery) {
          _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 280), () {
            // Trigger a localized rebuild to run the filter and update UI
            setState(() {
              _debouncedQuery = query;
            });
          });

          if (_cachedResults.isNotEmpty) {
            return _buildResultList(context); // Pass context
          }
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text('Searching…', style: TextStyle(color: Colors.grey)),
            ),
          );
        }

        // ── Layer 1: Data cache ────────────────────────────────────────────────
        if (query != _lastQuery) {
          _lastQuery = query;
          final q = query.toLowerCase();
          _cachedResults = products.where((p) {
            return p.name.toLowerCase().contains(q) ||
                p.category.toLowerCase().contains(q) ||
                (p.barcode ?? '').contains(q);
          }).toList();
        }

        if (_cachedResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No products found for "$query"',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async {
                    final newProduct =
                        await context.push<Product?>('/inventory/create');
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

        return _buildResultList(context); // Pass context
      },
    );
  }

  Widget _buildResultList(BuildContext context) {
    // itemExtent: Flutter knows the exact tile height upfront and skips the
    // layout measurement pass for all off-screen tiles. Critical for 300+ items.
    return ListView.builder(
      itemExtent: 72.0,
      itemCount: _cachedResults.length,
      itemBuilder: (context, index) {
        final product = _cachedResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.shade50,
            child: Text(
              product.name[0].toUpperCase(),
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(product.name,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${product.category} · ${product.unit}',
              style: const TextStyle(fontSize: 12)),
          trailing: product.averageSellingPrice != null &&
                  product.averageSellingPrice! > 0
              ? Text(
                  'PHP ${product.averageSellingPrice!.toInt()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                )
              : null,
          onTap: () => close(context, product),
        );
      },
    );
  }
}
