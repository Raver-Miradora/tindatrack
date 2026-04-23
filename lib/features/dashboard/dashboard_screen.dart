import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(activeAlertsProvider);
    final activityAsync = ref.watch(recentActivityProvider);
    final predictiveItems = ref.watch(predictiveProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TindaTrack', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Future: Route to settings
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Future functionality for manual refresh
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAlertBanner(alertsAsync),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildCriticalItemsStrip(context, predictiveItems), 
              const SizedBox(height: 24),
              const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildRecentActivity(activityAsync),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertBanner(AsyncValue alertsAsync) {
    return alertsAsync.when(
      data: (alerts) {
        if (alerts.isEmpty) {
          return _buildCard(
            color: Colors.green.shade50,
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Store is Running Smoothly',
            subtitle: 'No active stock alerts.',
          );
        }
        return _buildCard(
          color: Colors.orange.shade50,
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.orange,
          title: '${alerts.length} Action(s) Required',
          subtitle: 'Tap to review low stock or discrepancies.',
          onTap: () {
            // Future: Route to Alerts Screen
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Error loading alerts: $e'),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/stock-in'),
            icon: const Icon(Icons.add_shopping_cart, size: 24),
            label: const Text('Stock In'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/physical-count'),
            icon: const Icon(Icons.fact_check_outlined, size: 24),
            label: const Text('Count Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCriticalItemsStrip(BuildContext context, List<PredictedProduct> items) {
    if (items.isEmpty) {
       return const SizedBox.shrink();
    }

    final redItems = items.where((i) => i.isCritical).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Critical Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (redItems.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                child: Text('${redItems.length} Warning', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final pred = items[index];
              final product = pred.product;

               return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: pred.isCritical ? Colors.red.shade200 : Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      pred.isCritical ? Icons.report_problem : Icons.inventory_2, 
                      color: pred.isCritical ? Colors.red : Colors.orange, 
                      size: 24
                    ),
                    const Spacer(),
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(
                      pred.daysLeft < 1 
                        ? 'Out today!' 
                        : 'Est. ${pred.daysLeft.toStringAsFixed(1)} days left', 
                      style: TextStyle(
                        color: pred.isCritical ? Colors.red.shade700 : Colors.orange.shade700, 
                        fontSize: 11,
                        fontWeight: pred.isCritical ? FontWeight.bold : FontWeight.normal,
                      )
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(AsyncValue activityAsync) {
    return activityAsync.when(
      data: (logs) {
        if (logs.isEmpty) {
          return const Text('No recent activity.', style: TextStyle(color: Colors.grey));
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.history, color: Colors.grey),
              ),
              title: Text(log.actionType),
              subtitle: Text(log.timestamp.toString()),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Error: $e'),
    );
  }

  Widget _buildCard({required Color color, required IconData icon, required Color iconColor, required String title, required String subtitle, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: TextStyle(color: Colors.black.withValues(alpha: 0.7))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
