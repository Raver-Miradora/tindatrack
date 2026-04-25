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
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Store Reports', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(financialReportProvider),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildFinancialSummary(context, reportAsync),
            const SizedBox(height: 24),
            _buildQuickStatsGrid(reportAsync),
            const SizedBox(height: 32),
            const Text('Detailed Analytics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
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
              trailing: _buildRiskBadge(reportAsync),
              onTap: () {
                 // Future: Detailed Sales Report
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummary(BuildContext context, AsyncValue<FinancialReport> reportAsync) {
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);
    final timeFormat = DateFormat('HH:mm:ss');

    return reportAsync.when(
      data: (report) => Card(
        elevation: 12,
        shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, const Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total In-Stock Value', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(
                    'Updated ${timeFormat.format(report.lastUpdated)}',
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                currencyFormat.format(report.totalInventoryValue),
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -0.5),
              ),
              const SizedBox(height: 4),
              const Text('Current Asset Worth (Based on items in store)', style: TextStyle(color: Colors.white70, fontSize: 11)),
              const SizedBox(height: 24),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMiniStat('Est. Sales (Mo)', currencyFormat.format(report.estSales)),
                  _buildMiniStat('Shrinkage Rate', '${report.shrinkageRate.toStringAsFixed(1)}%', alignEnd: true),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildQuickStatsGrid(AsyncValue<FinancialReport> reportAsync) {
    return reportAsync.when(
      data: (report) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2,
        children: [
          _buildStatCard('Stocked SKUs', report.totalSkusInStock.toString(), Icons.inventory_2_outlined, Colors.blue),
          _buildStatCard('Stockout Risks', report.stockoutRiskCount.toString(), Icons.warning_amber_rounded, report.stockoutRiskCount > 0 ? Colors.red : Colors.green),
        ],
      ),
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: color.withValues(alpha: 0.8), size: 24),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBadge(AsyncValue<FinancialReport> reportAsync) {
    return reportAsync.when(
      data: (report) => report.stockoutRiskCount > 0 
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
            child: Text('${report.stockoutRiskCount} Critical', style: TextStyle(color: Colors.red.shade900, fontSize: 10, fontWeight: FontWeight.bold)),
          )
        : const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildMiniStat(String label, String value, {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildReportTile(BuildContext context, {required IconData icon, required String title, required String subtitle, Widget? trailing, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        trailing: trailing ?? const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
