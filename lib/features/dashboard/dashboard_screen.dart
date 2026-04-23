import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dashboard_providers.dart';
import '../../core/database/database.dart';
import '../../core/logic/log_parser.dart';
import '../../core/logic/haptics.dart';
import '../../core/widgets/async_value_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(dashboardStatusProvider);
    final activityAsync = ref.watch(recentActivityProvider);
    final predictiveItems = ref.watch(predictiveProductsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('TindaTrack', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              TindaHaptics.selection();
              context.push('/settings');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await TindaHaptics.success();
          ref.invalidate(dashboardStatusProvider);
          ref.invalidate(recentActivityProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusBanner(statusAsync),
              const SizedBox(height: 28),
              _buildQuickActions(context),
              const SizedBox(height: 32),
              _buildCriticalItemsStrip(context, predictiveItems), 
              const SizedBox(height: 32),
              _buildActivityHeader(context),
              const SizedBox(height: 12),
              AsyncValueWidget(
                value: activityAsync,
                data: (logs) => _buildRecentActivity(logs),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        TextButton(
          onPressed: () {
            TindaHaptics.selection();
            context.push('/audit-log');
          },
          child: Text('View All', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildStatusBanner(AsyncValue<DashboardStatus> statusAsync) {
    return AsyncValueWidget(
      value: statusAsync,
      data: (status) => _buildCard(
        color: status.color,
        icon: status.icon,
        title: status.title,
        subtitle: status.subtitle,
        onTap: () {
          TindaHaptics.light();
        },
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionBtn(
            context, 
            'Stock In', 
            Icons.add_shopping_cart, 
            Theme.of(context).primaryColor, 
            () {
              TindaHaptics.success();
              context.push('/stock-in');
            }
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionBtn(
            context, 
            'Count Now', 
            Icons.fact_check_outlined, 
            const Color(0xFF1976D2), 
            () {
              TindaHaptics.success();
              context.push('/physical-count');
            }
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn(BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildCriticalItemsStrip(BuildContext context, List<PredictedProduct> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Critical Predictions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            padding: const EdgeInsets.only(bottom: 8),
            itemBuilder: (context, index) {
              final pred = items[index];
              return _buildCriticalCard(pred);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCriticalCard(PredictedProduct pred) {
    final bool isCritical = pred.isCritical;
    final Color accentColor = isCritical ? const Color(0xFFD32F2F) : const Color(0xFFF57C00);

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(isCritical ? Icons.report_problem_rounded : Icons.inventory_2_rounded, color: accentColor, size: 18),
          ),
          const Spacer(),
          Text(pred.product.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(
            pred.daysLeft < 1 ? 'Out today!' : 'Est. ${pred.daysLeft.toStringAsFixed(1)} days', 
            style: TextStyle(color: accentColor, fontSize: 12, fontWeight: isCritical ? FontWeight.w900 : FontWeight.w600)
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(List<AuditLogData> logs) {
    if (logs.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const Text('No activity yet.', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
      );
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: logs.length,
        separatorBuilder: (context, index) => Divider(height: 1, indent: 64, color: Colors.grey.shade100),
        itemBuilder: (context, index) {
          final log = logs[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: _getActivityIcon(log.actionType),
            title: Text(_formatActionTitle(log.actionType), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LogParser.getSummary(log), style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4)),
                const SizedBox(height: 4),
                Text(_formatTimestamp(log.timestamp), style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
              ],
            ),
            onTap: () {
              TindaHaptics.light();
            },
          );
        },
      ),
    );
  }

  Widget _getActivityIcon(String actionType) {
    IconData icon;
    Color color;
    
    if (actionType.contains('Delivery') || actionType.contains('Stock')) {
      icon = Icons.local_shipping_rounded;
      color = const Color(0xFF2E7D32);
    } else if (actionType.contains('Count')) {
      icon = Icons.fact_check_rounded;
      color = const Color(0xFF1565C0);
    } else {
      icon = Icons.history_rounded;
      color = Colors.blueGrey;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: color, size: 22),
    );
  }

  String _formatActionTitle(String actionType) {
    if (actionType == 'New Delivery') return 'Stock Replenished';
    if (actionType == 'Count Discrepancy') return 'Inventory Adjusted';
    return actionType;
  }

  String _formatTimestamp(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Widget _buildCard({required Color color, required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.darken(0.15)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)),
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ColorUtils on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

const Color whiteCC = Color(0xCCFFFFFF);
