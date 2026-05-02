import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';
import 'package:go_router/go_router.dart';

// ── Result Model ──────────────────────────────────────────────────────────────

/// Returned from ProductCreateScreen so the calling screen can immediately
/// inject the new product into the delivery cart without a second scan.
class ProductCreateResult {
  final Product product;

  /// Number of units received in the initial delivery. 0 means "no delivery
  /// recorded yet" — the product was created but not stocked immediately.
  final double initialQty;

  /// Total cost of the initial delivery batch (used to compute unit cost).
  final double totalDeliveryCost;

  double get unitCost =>
      (initialQty > 0 && totalDeliveryCost > 0)
          ? totalDeliveryCost / initialQty
          : product.averageCost;

  const ProductCreateResult({
    required this.product,
    this.initialQty = 0.0,
    this.totalDeliveryCost = 0.0,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class ProductCreateScreen extends ConsumerStatefulWidget {
  final String? initialBarcode;
  const ProductCreateScreen({super.key, this.initialBarcode});

  @override
  ConsumerState<ProductCreateScreen> createState() =>
      _ProductCreateScreenState();
}

class _ProductCreateScreenState extends ConsumerState<ProductCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _barcodeController;
  late TextEditingController _priceController;
  late TextEditingController _costController;

  // ── Initial delivery fields removed ──

  String _category = 'Beverages';
  String _unit = 'pcs';

  final List<String> _categories = [
    'Beverages',
    'Alcohol',
    'Snacks',
    'Canned Goods',
    'Personal Care',
    'Condiments',
    'Household'
  ];
  final List<String> _units = [
    'pcs',
    'sachet',
    'bottle',
    'can',
    'pack',
    'kg'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _barcodeController =
        TextEditingController(text: widget.initialBarcode);
    _priceController = TextEditingController();
    _costController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _priceController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    TindaHaptics.success();
    final db = ref.read(databaseProvider);
    final id = const Uuid().v4();

    final price = double.tryParse(_priceController.text) ?? 0.0;
    final cost = double.tryParse(_costController.text) ?? 0.0;
    final initialQty = 0.0;
    final totalDeliveryCost = 0.0;

    final companion = ProductsCompanion.insert(
      id: id,
      name: _nameController.text.trim(),
      barcode: drift.Value(
          _barcodeController.text.isEmpty ? null : _barcodeController.text),
      category: _category,
      unit: _unit,
      reorderPoint: 10.0,
      averageSellingPrice: drift.Value(price),
      averageCost: drift.Value(cost),
      // Set initial stock if an initial delivery qty was provided
      currentStock: drift.Value(initialQty > 0 ? initialQty : 0.0),
      updatedAt: drift.Value(DateTime.now()),
    );

    await db.into(db.products).insert(companion);

    // Fetch the full product to return it
    final newProduct =
        await (db.select(db.products)..where((p) => p.id.equals(id)))
            .getSingle();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product created successfully!')));
      // Return the full result so the caller can inject it into the cart
      context.pop(ProductCreateResult(
        product: newProduct,
        initialQty: initialQty,
        totalDeliveryCost: totalDeliveryCost,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('I-rehistro ang Paninda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Core Fields ─────────────────────────────────────────────
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                    labelText: 'Product Name*',
                    border: OutlineInputBorder()),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _barcodeController,
                decoration: const InputDecoration(
                    labelText: 'Barcode (Optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.qr_code)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder()),
                      items: _categories
                          .map((c) =>
                              DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _category = v!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _unit,
                      decoration: const InputDecoration(
                          labelText: 'Unit',
                          border: OutlineInputBorder()),
                      items: _units
                          .map((u) =>
                              DropdownMenuItem(value: u, child: Text(u)))
                          .toList(),
                      onChanged: (v) => setState(() => _unit = v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _costController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Purchase Cost (PHP)',
                          border: OutlineInputBorder(),
                          prefixText: '₱ '),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Selling Price (PHP)',
                          border: OutlineInputBorder(),
                          prefixText: '₱ '),
                    ),
                  ),
                ],
              ),

              // ── Fields removed ──

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Register Product',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
