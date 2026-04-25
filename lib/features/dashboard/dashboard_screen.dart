import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dashboard_providers.dart';
import '../settings/settings_controller.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/logic/haptics.dart';
import '../../core/logic/log_parser.dart';
import '../../core/database/database.dart';

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

  Widget _buildStatusBanner(BuildContext context, DashboardStatus status) {
    return Container(
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
    );
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
        _buildActionCard(context, Icons.add_shopping_cart, 'Stock In', const Color(0xFFE3F2FD), Colors.blue, '/stock-in'),
        _buildActionCard(context, Icons.fact_check_outlined, 'Count', const Color(0xFFF1F8E9), Colors.green, '/physical-count'),
        _buildActionCard(context, Icons.bar_chart_rounded, 'Reports', const Color(0xFFFFF3E0), Colors.orange, '/reports'),
        _buildActionCard(context, Icons.inventory_2_outlined, 'Products', const Color(0xFFF3E5F5), Colors.purple, '/inventory'),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String label, Color bg, Color color, String route) {
    return InkWell(
      onTap: () {
        TindaHaptics.selection();
        context.push(route);
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
