import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/database/database.dart';
import '../../../core/providers.dart';
import '../../../core/logic/haptics.dart';


class LogExpenseDialog extends ConsumerStatefulWidget {
  const LogExpenseDialog({super.key});

  @override
  ConsumerState<LogExpenseDialog> createState() => _LogExpenseDialogState();
}

class _LogExpenseDialogState extends ConsumerState<LogExpenseDialog> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  bool _isProcessing = false;

  final List<String> _commonExpenses = ["Pamasahe", "Plastic Bags", "Meryenda", "Panukli"];

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveExpense() async {
    final amount = double.tryParse(_amountController.text.trim());
    final description = _descController.text.trim();

    if (amount == null || amount <= 0 || description.isEmpty) return;

    setState(() => _isProcessing = true);
    TindaHaptics.medium();

    final db = ref.read(databaseProvider);

    try {
      await db.into(db.storeExpenses).insert(
        StoreExpensesCompanion.insert(
          amount: amount,
          description: description,
          timestamp: drift.Value(DateTime.now()),
        ),
      );
      
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to log expense')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          const Text('Palabas na Pera (Store Expense)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: 'Halaga (Amount)',
              prefixText: 'PHP ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.red.shade700, width: 2)),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          
          TextField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: 'Para Saan? (Description)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.red.shade700, width: 2)),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          
          Wrap(
            spacing: 8,
            children: _commonExpenses.map((chipLabel) {
              return ActionChip(
                label: Text(chipLabel),
                backgroundColor: Colors.grey.shade100,
                onPressed: () {
                  _descController.text = chipLabel;
                  setState(() {});
                },
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: (_amountController.text.isNotEmpty && _descController.text.isNotEmpty && !_isProcessing) 
              ? _saveExpense 
              : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: _isProcessing 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('I-Save ang Gastos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
