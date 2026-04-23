import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'reports_controller.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(financialReportProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Store Reports'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFinancialSummary(context, reportAsync),
          const SizedBox(height: 24),
          const Text('Detailed Analytics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildReportTile(
            context,
            icon: Icons.history_rounded,
            title: 'Audit Log',
            subtitle: 'Chronological list of all system actions',
            onTap: () => context.push('/audit-log'),
          ),
          _buildReportTile(
            context,
            icon: Icons.trending_up_rounded,
            title: 'Inventory Performance',
            subtitle: 'Burn rates and stockout predictions',
            onTap: () {
               // Future: Detailed Sales Report
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary(BuildContext context, AsyncValue<FinancialReport> reportAsync) {
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);

    return reportAsync.when(
      data: (report) => Card(
        elevation: 8,
        shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, const Color(0xFF1B5E20)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Financial Snapshot', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text(
                currencyFormat.format(report.estSales),
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              const Text('Est. Sales (This Month)', style: TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(height: 20),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMiniStat('Total Variance', currencyFormat.format(report.totalVariance)),
                  _buildMiniStat('Shrinkage Rate', '${report.shrinkageRate.toStringAsFixed(1)}%', alignEnd: true),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
      error: (e, st) => Card(
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error loading report: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _buildReportTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}
