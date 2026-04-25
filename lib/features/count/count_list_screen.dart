import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'count_controller.dart';
import '../../core/database/database.dart';
import '../../core/logic/haptics.dart';

class CountListScreen extends ConsumerWidget {
  const CountListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastSessionsAsync = ref.watch(pastSessionsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Count History', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: pastSessionsAsync.when(
        data: (sessions) => sessions.isEmpty 
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return _buildSessionCard(context, session);
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showStartDialog(context, ref),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Physical Count', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fact_check_outlined, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          const Text('No count history found', style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text('Track physical stock to prevent loss', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, CountSession session) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
          child: const Icon(Icons.inventory_2_outlined, color: Colors.blue, size: 20),
        ),
        title: Text('Full Reconciliation', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
        subtitle: Text('Completed ${_formatDate(session.completedAt)}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          TindaHaptics.selection();
          // Navigate to audit log filtered by counts for this period
          context.push('/audit-log');
        },
      ),
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return 'Unknown';
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  void _showStartDialog(BuildContext context, WidgetRef ref) {
    TindaHaptics.selection();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Start Physical Count', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('This will generate a list of all products currently in stock. You can then enter the actual numbers found on your shelves.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              TindaHaptics.success();
              Navigator.pop(context);
              // FIXED: Navigate to correct route from router.dart
              context.push('/physical-count/new');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Start Count'),
          ),
        ],
      ),
    );
  }
}
