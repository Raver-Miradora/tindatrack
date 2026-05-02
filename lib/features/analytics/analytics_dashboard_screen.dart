import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'analytics_provider.dart';

class AnalyticsDashboardScreen extends ConsumerWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsProvider);
    final currency = NumberFormat.currency(symbol: '₱', decimalDigits: 0);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1923),
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pagsusuri ng Benta',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white)),
            Text('Analytics & Insights',
                style: TextStyle(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: analyticsAsync.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF00E5A0)),
              SizedBox(height: 16),
              Text('Kinukuwenta ang datos…',
                  style: TextStyle(color: Colors.white54, fontSize: 14)),
            ],
          ),
        ),
        error: (e, _) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
        data: (data) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            // ── Section 1: Time Period Cards ────────────────────────────────
            _sectionHeader('Buod ng Benta'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                _periodCard(context, 'Ngayon', 'Today',
                    data.today.totalRevenue, data.today.transactionCount,
                    const Color(0xFF00E5A0), const Color(0xFF00897B), currency),
                _periodCard(context, 'Lingguhang Benta', 'This Week',
                    data.thisWeek.totalRevenue, data.thisWeek.transactionCount,
                    const Color(0xFF82B1FF), const Color(0xFF1565C0), currency),
                _periodCard(context, 'Buwanang Benta', 'This Month',
                    data.thisMonth.totalRevenue, data.thisMonth.transactionCount,
                    const Color(0xFFFFD740), const Color(0xFFF9A825), currency),
                _periodCard(context, 'Taunang Benta', 'This Year',
                    data.thisYear.totalRevenue, data.thisYear.transactionCount,
                    const Color(0xFFFF80AB), const Color(0xFFAD1457), currency),
              ],
            ),

            // ── Section 2: Top Earners ──────────────────────────────────────
            const SizedBox(height: 32),
            _sectionHeader('Pinaka-Mabentang Produkto', subtitle: 'Top Earners (30 Days)'),
            const SizedBox(height: 12),
            if (data.topEarners.isEmpty)
              _emptyState('Walang sales data para sa nakalipas na 30 araw.')
            else
              ...data.topEarners.asMap().entries.map((entry) {
                final rank = entry.key;
                final stat = entry.value;
                return _productCard(
                  rank: rank,
                  name: stat.productName,
                  primary: currency.format(stat.revenue),
                  secondary: '${stat.quantitySold} pcs sold',
                  accentColor: rank == 0
                      ? const Color(0xFFFFD740)
                      : rank == 1
                          ? Colors.grey.shade400
                          : const Color(0xFFFF8A65),
                  icon: rank == 0
                      ? Icons.emoji_events_rounded
                      : rank <= 2
                          ? Icons.star_rounded
                          : Icons.trending_up_rounded,
                );
              }),

            // ── Section 3: Top Sellers (by qty) ────────────────────────────
            const SizedBox(height: 32),
            _sectionHeader('Pinaka-Popular na Produkto', subtitle: 'Most Sold (30 Days)'),
            const SizedBox(height: 12),
            if (data.topSellers.isEmpty)
              _emptyState('Walang sales data para sa nakalipas na 30 araw.')
            else
              ...data.topSellers.asMap().entries.map((entry) {
                final rank = entry.key;
                final stat = entry.value;
                return _productCard(
                  rank: rank,
                  name: stat.productName,
                  primary: '${stat.quantitySold} pieces',
                  secondary: currency.format(stat.revenue),
                  accentColor: rank == 0
                      ? const Color(0xFF00E5A0)
                      : const Color(0xFF82B1FF),
                  icon: rank == 0
                      ? Icons.local_fire_department_rounded
                      : Icons.bar_chart_rounded,
                );
              }),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.3)),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(subtitle,
              style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ],
    );
  }

  Widget _periodCard(
    BuildContext context,
    String labelTl,
    String labelEn,
    double revenue,
    int txCount,
    Color accentColor,
    Color deepColor,
    NumberFormat currency,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.15),
            deepColor.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(labelTl,
              style: TextStyle(
                  color: accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              currency.format(revenue),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.receipt_rounded, color: accentColor.withValues(alpha: 0.7), size: 12),
              const SizedBox(width: 4),
              Text('$txCount transactions',
                  style: TextStyle(color: Colors.white54, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productCard({
    required int rank,
    required String name,
    required String primary,
    required String secondary,
    required Color accentColor,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rank == 0
              ? accentColor.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: rank < 3
                  ? Icon(icon, color: accentColor, size: 20)
                  : Text(
                      '#${rank + 1}',
                      style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 12),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(secondary,
                    style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          // Primary metric
          Text(
            primary,
            style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w900,
                fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(String message) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(message,
            style: const TextStyle(color: Colors.white38, fontSize: 14),
            textAlign: TextAlign.center),
      ),
    );
  }
}
