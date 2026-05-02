import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/providers.dart';

// ── Provider ──────────────────────────────────────────────────────────────────

class SelectedSalesDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void goBack() => state = state.subtract(const Duration(days: 1));
  void goForward() => state = state.add(const Duration(days: 1));
  void setDate(DateTime date) => state = date;
}

final selectedSalesDateProvider =
    NotifierProvider.autoDispose<SelectedSalesDateNotifier, DateTime>(
  SelectedSalesDateNotifier.new,
);

enum LedgerItemType { cashSale, creditSale, utangPayment, expense }

class DailyLedgerItem {
  final LedgerItemType type;
  final String title;
  final String description;
  final double amount;
  final DateTime timestamp;

  DailyLedgerItem({
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.timestamp,
  });
}

class DailyLedgerStats {
  final double grossSales;
  final double cashSales;
  final double utangSales;
  final double utangPayments;
  final double expenses;
  final int totalTransactions;
  
  double get expectedCashInDrawer => cashSales + utangPayments - expenses;

  DailyLedgerStats({
    required this.grossSales,
    required this.cashSales,
    required this.utangSales,
    required this.utangPayments,
    required this.expenses,
    required this.totalTransactions,
  });
}

final unifiedDailyLedgerProvider =
    FutureProvider.autoDispose.family<List<DailyLedgerItem>, DateTime>(
  (ref, date) async {
    final db = ref.watch(databaseProvider);
    final start = DateTime(date.year, date.month, date.day);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final List<DailyLedgerItem> items = [];

    // Fetch Sales
    final sales = await (db.select(db.salesTransactions)
          ..where((t) => t.timestamp.isBetweenValues(start, end)))
        .get();

    for (final s in sales) {
      items.add(DailyLedgerItem(
        type: s.paymentMethod == 'CREDIT' ? LedgerItemType.creditSale : LedgerItemType.cashSale,
        title: s.paymentMethod == 'CREDIT' ? '[UTANG] POS Sale' : 'POS Sale',
        description: s.itemsSnapshot,
        amount: s.totalAmount,
        timestamp: s.timestamp,
      ));
    }

    // Fetch Utang Payments (Amount < 0)
    final ledgers = await (db.select(db.utangLedger)
          ..where((t) => t.timestamp.isBetweenValues(start, end))
          ..where((t) => t.amount.isSmallerThanValue(0)))
        .get();

    for (final l in ledgers) {
      // Get customer name for nicer UI
      final customer = await (db.select(db.customers)..where((c) => c.id.equals(l.customerId))).getSingleOrNull();
      items.add(DailyLedgerItem(
        type: LedgerItemType.utangPayment,
        title: 'Utang Payment',
        description: customer != null ? 'From: ${customer.name}' : (l.description ?? 'Payment'),
        amount: l.amount.abs(), // use absolute for UI
        timestamp: l.timestamp,
      ));
    }

    // Fetch Store Expenses
    final expenses = await (db.select(db.storeExpenses)
          ..where((t) => t.timestamp.isBetweenValues(start, end)))
        .get();

    for (final e in expenses) {
      items.add(DailyLedgerItem(
        type: LedgerItemType.expense,
        title: 'Store Expense',
        description: e.description,
        amount: e.amount,
        timestamp: e.timestamp,
      ));
    }

    // Sort chronologically (newest first)
    items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return items;
  },
);

final dailyLedgerStatsProvider =
    Provider.autoDispose.family<DailyLedgerStats, List<DailyLedgerItem>>(
  (ref, items) {
    double gross = 0;
    double cash = 0;
    double utang = 0;
    double payments = 0;
    double expenses = 0;
    int txCount = 0;

    for (final item in items) {
      if (item.type == LedgerItemType.cashSale) {
        gross += item.amount;
        cash += item.amount;
        txCount++;
      } else if (item.type == LedgerItemType.creditSale) {
        gross += item.amount;
        utang += item.amount;
        txCount++;
      } else if (item.type == LedgerItemType.utangPayment) {
        payments += item.amount;
      } else if (item.type == LedgerItemType.expense) {
        expenses += item.amount;
      }
    }

    return DailyLedgerStats(
      grossSales: gross,
      cashSales: cash,
      utangSales: utang,
      utangPayments: payments,
      expenses: expenses,
      totalTransactions: txCount,
    );
  },
);

// ── Screen ────────────────────────────────────────────────────────────────────

class DailyTransactionsScreen extends ConsumerWidget {
  const DailyTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedSalesDateProvider);
    final transactionsAsync = ref.watch(unifiedDailyLedgerProvider(selectedDate));

    final dateFormat = DateFormat('EEEE, MMMM d, y');
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);
    final timeFormat = DateFormat('h:mm a');

    final today = DateTime.now();
    final isToday = selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Kasaysayan ng Benta',
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Date Selector ─────────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, size: 32),
                  onPressed: () {
                    ref.read(selectedSalesDateProvider.notifier).goBack();
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: today,
                    );
                    if (picked != null) {
                      ref.read(selectedSalesDateProvider.notifier).setDate(picked);
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        isToday ? 'Ngayon' : dateFormat.format(selectedDate),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      if (!isToday)
                        const SizedBox.shrink()
                      else
                        Text(
                          dateFormat.format(selectedDate),
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade500),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.chevron_right_rounded,
                    size: 32,
                    color: isToday ? Colors.grey.shade300 : null,
                  ),
                  onPressed: isToday
                      ? null
                      : () {
                          ref.read(selectedSalesDateProvider.notifier).goForward();
                        },
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // ── Summary + List ────────────────────────────────────────────────
          Expanded(
            child: transactionsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
              data: (items) {
                final stats = ref.watch(dailyLedgerStatsProvider(items));

                return Column(
                  children: [
                    // Summary Card
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              const Color(0xFF004D40)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text('Expected Cash in Drawer',
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(
                                      currencyFormat.format(stats.expectedCashInDrawer),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -0.5),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${stats.totalTransactions}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const Text('Transaksyon',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(color: Colors.white24),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Gross Sales', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                                      Text(currencyFormat.format(stats.grossSales), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(width: 1, height: 30, color: Colors.white24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Utang Sales', style: TextStyle(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                                      Text(currencyFormat.format(stats.utangSales), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(width: 1, height: 30, color: Colors.white24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Expenses', style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                                      Text(currencyFormat.format(stats.expenses), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Transactions List
                    Expanded(
                      child: items.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.receipt_long_outlined,
                                      size: 64,
                                      color: Colors.grey.shade300),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Walang benta sa araw na ito.',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 0, 20, 20),
                              itemCount: items.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final item = items[index];

                                Color bgColor;
                                Color iconColor;
                                IconData icon;
                                String prefix;

                                if (item.type == LedgerItemType.cashSale) {
                                  bgColor = Colors.green.shade50;
                                  iconColor = Colors.green.shade700;
                                  icon = Icons.receipt_rounded;
                                  prefix = '+ ';
                                } else if (item.type == LedgerItemType.creditSale) {
                                  bgColor = Colors.orange.shade50;
                                  iconColor = Colors.orange.shade700;
                                  icon = Icons.receipt_long;
                                  prefix = '+ ';
                                } else if (item.type == LedgerItemType.utangPayment) {
                                  bgColor = Colors.blue.shade50;
                                  iconColor = Colors.blue.shade700;
                                  icon = Icons.account_balance_wallet;
                                  prefix = '+ ';
                                } else { // Expense
                                  bgColor = Colors.red.shade50;
                                  iconColor = Colors.red.shade700;
                                  icon = Icons.money_off;
                                  prefix = '- ';
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.grey.shade100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.03),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10),
                                    leading: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Icon(icon, color: iconColor, size: 22),
                                    ),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: iconColor,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          timeFormat.format(item.timestamp),
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        item.description,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    trailing: Text(
                                      '$prefix${currencyFormat.format(item.amount)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                          color: iconColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
