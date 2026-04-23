import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';
import 'package:go_router/go_router.dart';

class ProductCreateScreen extends ConsumerStatefulWidget {
  final String? initialBarcode;
  const ProductCreateScreen({super.key, this.initialBarcode});

  @override
  ConsumerState<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends ConsumerState<ProductCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _barcodeController;
  late TextEditingController _priceController;
  late TextEditingController _costController;
  String _category = 'Beverages';
  String _unit = 'pcs';

  final List<String> _categories = ['Beverages', 'Alcohol', 'Snacks', 'Canned Goods', 'Personal Care', 'Condiments', 'Household'];
  final List<String> _units = ['pcs', 'sachet', 'bottle', 'can', 'pack', 'kg'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _barcodeController = TextEditingController(text: widget.initialBarcode);
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
    if (_formKey.currentState!.validate()) {
      TindaHaptics.success();
      final db = ref.read(databaseProvider);
      final id = const Uuid().v4();
      
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final cost = double.tryParse(_costController.text) ?? 0.0;

      final companion = ProductsCompanion.insert(
        id: id,
        name: _nameController.text,
        barcode: drift.Value(_barcodeController.text.isEmpty ? null : _barcodeController.text),
        category: _category,
        unit: _unit,
        reorderPoint: 10.0,
        averageSellingPrice: drift.Value(price),
        averageCost: drift.Value(cost),
        currentStock: drift.Value(0.0),
        updatedAt: drift.Value(DateTime.now()),
      );

      await db.into(db.products).insert(companion);
      
      // Fetch the full product to return it
      final newProduct = await (db.select(db.products)..where((p) => p.id.equals(id))).getSingle();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product created successfully!')));
        // Return the product so the calling screen can auto-add it
        context.pop(newProduct);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name*', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _barcodeController,
                decoration: const InputDecoration(labelText: 'Barcode (Optional)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.qr_code)),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                      items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => _category = v!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _unit,
                      decoration: const InputDecoration(labelText: 'Unit', border: OutlineInputBorder()),
                      items: _units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
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
                      decoration: const InputDecoration(labelText: 'Purchase Cost (PHP)', border: OutlineInputBorder(), prefixText: '₱ '),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Selling Price (PHP)', border: OutlineInputBorder(), prefixText: '₱ '),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Save Product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
