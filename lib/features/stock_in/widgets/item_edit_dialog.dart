import 'package:flutter/material.dart';
import '../delivery_controller.dart';

class ItemEditDialog extends StatefulWidget {
  final DeliveryCartItem item;
  final Function(double qty, double cost) onConfirm;
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

  @override
  void initState() {
    super.initState();
    _qtyController = TextEditingController(text: widget.item.quantity.toString());
    _costController = TextEditingController(text: widget.item.unitCost.toString());
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _costController.dispose();
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
            Text('Unit: ${widget.item.product.unit}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: _qtyController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Quantity Received',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_box_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _costController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Unit Cost (PHP)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.payments_outlined),
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
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final qty = double.tryParse(_qtyController.text) ?? widget.item.quantity;
            final cost = double.tryParse(_costController.text) ?? widget.item.unitCost;
            widget.onConfirm(qty, cost);
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
