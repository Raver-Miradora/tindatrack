import 'package:flutter/material.dart';
import '../delivery_controller.dart';

class ItemEditDialog extends StatefulWidget {
  final DeliveryCartItem item;
  final Function(double qty, double cost, double price) onConfirm;
  final VoidCallback onRemove;

  const ItemEditDialog({
    super.key,
    required this.item,
    required this.onConfirm,
    required this.onRemove,
  });

  @override
  State<ItemEditDialog> createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  late TextEditingController _qtyController;
  late TextEditingController _costController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: widget.item.quantity.toInt().toString());
    _costController = TextEditingController(text: widget.item.unitCost.toStringAsFixed(2));
    _priceController = TextEditingController(text: widget.item.unitSellingPrice.toStringAsFixed(2));
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _costController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item.product.name),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unit: ${widget.item.product.unit}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
            TextField(
              controller: _qtyController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Quantity Received',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_box_outlined),
                isDense: true,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _costController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Unit Cost (PHP)',
                helperText: 'What you paid per item',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag_outlined),
                isDense: true,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Selling Price (PHP)',
                helperText: 'Store price for customers',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sell_outlined),
                isDense: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onRemove();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Remove'),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final qty = double.tryParse(_qtyController.text) ?? widget.item.quantity;
            final cost = double.tryParse(_costController.text) ?? widget.item.unitCost;
            final price = double.tryParse(_priceController.text) ?? widget.item.unitSellingPrice;
            widget.onConfirm(qty, cost, price);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
