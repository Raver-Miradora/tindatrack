import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'count_controller.dart';
import '../../core/database/database.dart';

class CountListScreen extends ConsumerWidget {
  const CountListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastSessionsAsync = ref.watch(pastSessionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Counts'),
      ),
      body: pastSessionsAsync.when(
        data: (sessions) => sessions.isEmpty 
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
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
        icon: const Icon(Icons.add),
        label: const Text('New Count'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fact_check_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No count history found', style: TextStyle(color: Colors.grey, fontSize: 18)),
          const SizedBox(height: 8),
          const Text('Perform your first physical count today!', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, CountSession session) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text('Count: ${session.countType.toUpperCase()}'),
        subtitle: Text('Completed: ${session.completedAt.toString().split('.')[0]}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: View session details
        },
      ),
    );
  }

  void _showStartDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start Physical Count'),
        content: const Text('Would you like to start a full inventory count? This will fetch all active products.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In the new AsyncNotifier, the build() method handles the initialization.
              // We just need to navigate to the session screen.
              context.push('/physical-count/session');
            },
            child: const Text('Start Full Count'),
          ),
        ],
      ),
    );
  }
}
