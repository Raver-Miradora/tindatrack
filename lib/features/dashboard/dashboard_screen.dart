import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dashboard_providers.dart';
import '../settings/settings_controller.dart';
import '../expenses/log_expense_dialog.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/logic/haptics.dart';
import '../../core/logic/log_parser.dart';
import '../../core/database/database.dart';
import '../../core/providers.dart';
import 'package:intl/intl.dart';


class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(dashboardStatusProvider);
    final activityAsync = ref.watch(recentActivityProvider);
    final storeName = ref.watch(storeNameProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: Text(storeName, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: -0.5)),
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {
              TindaHaptics.light();
              context.push('/settings');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardStatusProvider);
          ref.invalidate(recentActivityProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AsyncValueWidget(
              value: statusAsync,
              data: (status) => _buildStatusBanner(context, status),
            ),
            const SizedBox(height: 24),
            _buildLiveCashDrawer(context, ref),
            const SizedBox(height: 16),
            _buildActionGrid(context),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                TextButton(
                  onPressed: () => context.push('/audit-log'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AsyncValueWidget(
              value: activityAsync,
              data: (activities) => _buildActivityList(context, activities),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveCashDrawer(BuildContext context, WidgetRef ref) {
    final liveDataAsync = ref.watch(liveCashDrawerProvider);
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);

    return liveDataAsync.when(
      loading: () => const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => const SizedBox.shrink(),
      data: (data) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.teal.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Kasalukuyang Pera sa Kahera',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white70),
                    onPressed: () => _showEditFloatDialog(context, ref, data.baseFloat),
                    tooltip: 'Edit Base Float',
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                currencyFormat.format(data.currentCash),
                style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'Base Float: ${currencyFormat.format(data.baseFloat)} | Sales: +${currencyFormat.format(data.cashSales)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                'Utang Paid: +${currencyFormat.format(data.utangPaymentsReceived)} | Expenses/Loans: -${currencyFormat.format(data.expenses + data.cashLoansGiven)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditFloatDialog(BuildContext context, WidgetRef ref, double currentFloat) {
    final controller = TextEditingController(text: currentFloat > 0 ? currentFloat.toString() : '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Base Float'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Pondo (PHP)',
            prefixText: 'PHP ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newFloat = double.tryParse(controller.text.trim()) ?? 0.0;
              await ref.read(sharedPreferencesProvider).setDouble('base_cash_float', newFloat);
              // ignore: unused_result
              ref.refresh(liveCashDrawerProvider);
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, DashboardStatus status) {

    return GestureDetector(
      onTap: () {
        TindaHaptics.selection();
        if (status.title == 'Low Stock Warning') {
          context.push('/inventory', extra: true);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [status.color, status.color.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: status.color.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(status.icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                status.title,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            status.subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ));
  }

  Widget _buildActionGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildActionCard(context, Icons.point_of_sale, 'POS / Cashier', const Color(0xFFFFEbee), Colors.red, route: '/pos'),
        _buildActionCard(context, Icons.move_to_inbox_rounded, 'Update Inventory', const Color(0xFFE3F2FD), Colors.blue, route: '/stock-in'),
        _buildActionCard(context, Icons.inventory_2_outlined, 'Products', const Color(0xFFF3E5F5), Colors.purple, route: '/inventory'),
        _buildActionCard(context, Icons.receipt_long_rounded, 'Kasaysayan ng Benta', const Color(0xFFE8F5E9), Colors.teal, route: '/sales-history'),
        _buildActionCard(context, Icons.account_balance_wallet, 'Utang Ledger', const Color(0xFFFBE9E7), Colors.deepOrange, route: '/utang-list'),
        _buildActionCard(context, Icons.insights_rounded, 'Pagsusuri ng Benta', const Color(0xFFEDE7F6), Colors.deepPurple, route: '/analytics'),
        _buildActionCard(context, Icons.money_off, 'Palabas na Pera', const Color(0xFFFFEBEE), Colors.red.shade900, onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const LogExpenseDialog(),
          );
        }),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String label, Color bg, Color color, {String? route, VoidCallback? onTap}) {
    return InkWell(
      onTap: () {
        TindaHaptics.selection();
        if (onTap != null) {
          onTap();
        } else if (route != null) {
          context.push(route);
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color.withValues(alpha: 0.8), fontWeight: FontWeight.w800, fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context, List<AuditLogData> activities) {
    if (activities.isEmpty) {
      return const Center(child: Text('No recent activity', style: TextStyle(color: Colors.grey)));
    }
    return Column(
      children: activities.map((item) => _buildActivityItem(item)).toList(),
    );
  }

  Widget _buildActivityItem(AuditLogData item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle),
          child: Icon(_getIconForAction(item.actionType), color: Colors.grey.shade700, size: 20),
        ),
        title: Text(LogParser.getSummary(item), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        subtitle: Text(_formatTimestamp(item.timestamp), style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  IconData _getIconForAction(String action) {
    if (action.contains('Delivery')) return Icons.local_shipping_outlined;
    if (action.contains('Discrepancy')) return Icons.difference_outlined;
    return Icons.history;
  }

  String _formatTimestamp(DateTime ts) {
    final now = DateTime.now();
    final diff = now.difference(ts);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${ts.day}/${ts.month}';
  }
}
