import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';


// Helper class for UI
class CustomerUtangSummary {
  final Customer customer;
  final double balance;
  CustomerUtangSummary(this.customer, this.balance);
}

final customerUtangProvider = FutureProvider.autoDispose<List<CustomerUtangSummary>>((ref) async {
  final db = ref.watch(databaseProvider);
  
  // Custom query to get customers and their sum of utang
  final customers = await (db.select(db.customers)..orderBy([(t) => drift.OrderingTerm(expression: t.name)])).get();
  
  List<CustomerUtangSummary> summaries = [];
  for (var customer in customers) {
    final ledgers = await (db.select(db.utangLedger)..where((t) => t.customerId.equals(customer.id))).get();
    final balance = ledgers.fold(0.0, (sum, l) => sum + l.amount);
    
    // Only show customers with a non-zero balance
    if (balance.abs() > 0.01) {
      summaries.add(CustomerUtangSummary(customer, balance));
    }
  }
  
  return summaries;
});

class UtangListScreen extends ConsumerWidget {
  const UtangListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summariesAsync = ref.watch(customerUtangProvider);
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Listahan ng Utang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: summariesAsync.when(
        data: (summaries) {
          if (summaries.isEmpty) {
            return const Center(child: Text('Walang may utang ngayon!', style: TextStyle(color: Colors.grey, fontSize: 16)));
          }

          final totalUtang = summaries.fold(0.0, (sum, s) => sum + s.balance);

          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Collectibles:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(currencyFormat.format(totalUtang), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.red)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: summaries.length,
                  itemBuilder: (context, index) {
                    final summary = summaries[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        title: Text(summary.customer.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        trailing: Text(currencyFormat.format(summary.balance), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => UtangDetailScreen(customer: summary.customer, balance: summary.balance),
                          )).then((_) => ref.refresh(customerUtangProvider));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

// ── DETAIL SCREEN ────────────────────────────────────────────────────────────

class UtangDetailScreen extends ConsumerWidget {
  final Customer customer;
  final double balance;

  const UtangDetailScreen({super.key, required this.customer, required this.balance});

  void _showPaymentDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Bayad ni ${customer.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Balance: ${currencyFormat.format(balance)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Amount Paid',
                prefixText: 'PHP ',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            onPressed: () async {
              final amount = double.tryParse(controller.text.trim());
              if (amount != null && amount > 0) {
                final db = ref.read(databaseProvider);
                await db.into(db.utangLedger).insert(
                  UtangLedgerCompanion.insert(
                    id: const Uuid().v4(),
                    customerId: customer.id,
                    amount: -amount, // Negative for payment
                    timestamp: drift.Value(DateTime.now()),
                    description: const drift.Value('Payment Received'),
                  ),
                );
                TindaHaptics.success();
                if (ctx.mounted) Navigator.of(ctx).pop();
              }
            },
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
    );
  }

  void _showCashLoanDialog(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pautang ng Cash kay ${customer.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter the amount of cash you are loaning out.', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Amount (PHP)',
                prefixText: 'PHP ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Note / Dahilan (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
            onPressed: () async {
              final amount = double.tryParse(amountController.text.trim());
              if (amount != null && amount > 0) {
                final db = ref.read(databaseProvider);
                final note = noteController.text.trim();
                final description = note.isEmpty ? 'Cash Loan' : 'Cash Loan: $note';
                
                await db.into(db.utangLedger).insert(
                  UtangLedgerCompanion.insert(
                    id: const Uuid().v4(),
                    customerId: customer.id,
                    amount: amount, // Positive for debt incurred
                    timestamp: drift.Value(DateTime.now()),
                    description: drift.Value(description),
                    itemsSnapshot: drift.Value('Cash Loan'),
                  ),
                );
                TindaHaptics.success();
                if (ctx.mounted) Navigator.of(ctx).pop();
              }
            },
            child: const Text('Confirm Loan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);
    final dateFormat = DateFormat('MMM d, y - h:mm a');

    final ledgersAsync = ref.watch(FutureProvider.autoDispose((ref) {
      return (db.select(db.utangLedger)
            ..where((t) => t.customerId.equals(customer.id))
            ..orderBy([(t) => drift.OrderingTerm(expression: t.timestamp, mode: drift.OrderingMode.desc)]))
          .get();
    }));

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: Text(customer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text('Outstanding Balance', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(currencyFormat.format(balance), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.red)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: balance > 0 ? () => _showPaymentDialog(context, ref) : null,
                    icon: const Icon(Icons.money),
                    label: const Text('Magbayad (Receive Payment)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _showCashLoanDialog(context, ref),
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text('Pautang ng Cash (Cash Loan)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.orange.shade700,
                      side: BorderSide(color: Colors.orange.shade700, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ledgersAsync.when(
              data: (ledgers) => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ledgers.length,
                itemBuilder: (context, index) {
                  final ledger = ledgers[index];
                  final isPayment = ledger.amount < 0;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isPayment ? Colors.green.shade50 : Colors.red.shade50,
                      child: Icon(isPayment ? Icons.arrow_downward : Icons.arrow_upward, color: isPayment ? Colors.green : Colors.red),
                    ),
                    title: Text(ledger.description ?? (isPayment ? 'Payment' : 'Debt Incurred'), style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateFormat.format(ledger.timestamp), style: const TextStyle(fontSize: 12)),
                        if (ledger.itemsSnapshot != null && ledger.itemsSnapshot!.isNotEmpty)
                          Text(ledger.itemsSnapshot!, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
                      ],
                    ),
                    trailing: Text(currencyFormat.format(ledger.amount.abs()), style: TextStyle(fontWeight: FontWeight.bold, color: isPayment ? Colors.green : Colors.red, fontSize: 16)),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
