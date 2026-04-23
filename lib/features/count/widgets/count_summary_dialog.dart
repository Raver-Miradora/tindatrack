import 'package:flutter/material.dart';
import '../count_controller.dart';

class CountSummaryDialog extends StatelessWidget {
  final List<CountItemEntry> items;
  final VoidCallback onConfirm;

  const CountSummaryDialog({
    super.key,
    required this.items,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final discrepancies = items.where((i) => i.variance != 0).toList();
    final totalDiscrepancies = discrepancies.length;

    return AlertDialog(
      title: const Text('Confirm Inventory Count'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary for physical count:'),
            const SizedBox(height: 16),
            _buildStatRow('Total Items Counted', '${items.length}'),
            _buildStatRow('Discrepancies Found', '$totalDiscrepancies', color: totalDiscrepancies > 0 ? Colors.red : Colors.green),
            const Divider(height: 32),
            if (totalDiscrepancies > 0) ...[
              const Text('Top Discrepancies:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: discrepancies.length > 5 ? 5 : discrepancies.length,
                  itemBuilder: (context, index) {
                    final item = discrepancies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(item.product.name, style: const TextStyle(fontSize: 12))),
                          Text(
                            '${item.variance > 0 ? "-" : "+"}${item.variance.abs().toStringAsFixed(0)}',
                            style: TextStyle(color: item.variance > 0 ? Colors.red : Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (discrepancies.length > 5)
                const Text('...', style: TextStyle(color: Colors.grey)),
            ],
            const SizedBox(height: 16),
            const Text(
              'Finalizing will record these values and the variance as sales/shrinkage.',
              style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back to Count'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm & Save'),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
