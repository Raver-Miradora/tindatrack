import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../pos_cart_provider.dart';
import '../../../core/logic/haptics.dart';
import '../../../core/providers.dart';
import '../../../core/database/database.dart';
import 'package:drift/drift.dart' as drift;

// Provider to get customers
final customersProvider = FutureProvider.autoDispose<List<Customer>>((ref) async {
  final db = ref.watch(databaseProvider);
  return (db.select(db.customers)..orderBy([(t) => drift.OrderingTerm(expression: t.name)])).get();
});

class PosCheckoutUtangDialog extends ConsumerStatefulWidget {
  const PosCheckoutUtangDialog({super.key});

  @override
  ConsumerState<PosCheckoutUtangDialog> createState() => _PosCheckoutUtangDialogState();
}

class _PosCheckoutUtangDialogState extends ConsumerState<PosCheckoutUtangDialog> {
  bool _isProcessing = false;
  Customer? _selectedCustomer;
  final TextEditingController _newCustomerController = TextEditingController();

  @override
  void dispose() {
    _newCustomerController.dispose();
    super.dispose();
  }

  Future<void> _processUtang() async {
    if (_selectedCustomer == null && _newCustomerController.text.trim().isEmpty) return;

    setState(() => _isProcessing = true);
    TindaHaptics.medium();

    final db = ref.read(databaseProvider);
    String customerId;

    if (_selectedCustomer != null) {
      customerId = _selectedCustomer!.id;
    } else {
      customerId = const Uuid().v4();
      await db.into(db.customers).insert(
        CustomersCompanion.insert(
          id: customerId,
          name: _newCustomerController.text.trim(),
        ),
      );
    }

    final success = await ref.read(posCartProvider.notifier).finalizeSale(
      paymentMethod: 'CREDIT', 
      customerId: customerId,
    );
    
    if (!mounted) return;
    
    if (success) {
      context.pop(true);
    } else {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to process utang')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalDue = ref.watch(posCartTotalProvider);
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);
    final customersAsync = ref.watch(customersProvider);

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
          const Text('I-Utang Checkout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Debt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                Text(currencyFormat.format(totalDue), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.red)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          const Text('Select Customer', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          
          customersAsync.when(
            data: (customers) {
              return DropdownButtonFormField<Customer>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: const Text('Choose existing customer...'),
                // ignore: deprecated_member_use
                value: _selectedCustomer,
                items: customers.map((c) => DropdownMenuItem(value: c, child: Text(c.name))).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCustomer = val;
                    if (val != null) _newCustomerController.clear();
                  });
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => const Text('Error loading customers'),
          ),
          
          const SizedBox(height: 16),
          const Text('OR Create New Customer', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          
          TextField(
            controller: _newCustomerController,
            decoration: InputDecoration(
              labelText: 'New Customer Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && _selectedCustomer != null) {
                setState(() => _selectedCustomer = null);
              }
              setState(() {}); // trigger rebuild for button state
            },
          ),
          
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: ((_selectedCustomer != null || _newCustomerController.text.trim().isNotEmpty) && !_isProcessing) 
              ? _processUtang 
              : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: _isProcessing 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Confirm I-Utang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
