import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../pos_cart_provider.dart';
import '../../../core/logic/haptics.dart';

class PosCheckoutDialog extends ConsumerStatefulWidget {
  const PosCheckoutDialog({super.key});

  @override
  ConsumerState<PosCheckoutDialog> createState() => _PosCheckoutDialogState();
}

class _PosCheckoutDialogState extends ConsumerState<PosCheckoutDialog> {
  final TextEditingController _cashController = TextEditingController();
  double _cashTendered = 0;
  bool _isProcessing = false;

  @override
  void dispose() {
    _cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalDue = ref.watch(posCartTotalProvider);
    final changeDue = _cashTendered - totalDue;
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Checkout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Due', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                Text(currencyFormat.format(totalDue), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.blue)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _cashController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: 'Cash Tendered',
              prefixText: 'PHP ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.blue, width: 2)),
            ),
            onChanged: (val) {
              setState(() {
                _cashTendered = double.tryParse(val) ?? 0;
              });
            },
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ActionChip(
              backgroundColor: Colors.blue.shade50,
              side: BorderSide.none,
              label: const Text('Exact Amount (Sakto)', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  _cashController.text = totalDue.toString();
                  _cashTendered = totalDue;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Change Due', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(
                _cashTendered > 0 ? currencyFormat.format(changeDue > 0 ? changeDue : 0) : '---',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: changeDue >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: (_cashTendered >= totalDue && !_isProcessing) ? () async {
              setState(() => _isProcessing = true);
              TindaHaptics.medium();
              final success = await ref.read(posCartProvider.notifier).finalizeSale();
              if (!context.mounted) return;
              if (success) {
                context.pop(true);
              } else {
                setState(() => _isProcessing = false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to process sale')));
              }
            } : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: _isProcessing 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Confirm Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
