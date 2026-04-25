import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database.dart';
import '../../core/providers.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';

final auditLogsProvider = StreamProvider<List<AuditLogData>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.auditLog)
    ..orderBy([(u) => drift.OrderingTerm(expression: u.timestamp, mode: drift.OrderingMode.desc)]))
  .watch();
});

class AuditLogScreen extends ConsumerWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(auditLogsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Audit Trail', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('No activity recorded yet', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final log = logs[index];
              return _AuditLogTile(log: log);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _AuditLogTile extends StatelessWidget {
  final AuditLogData log;
  const _AuditLogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    final title = _getHumanAction(log.actionType);
    final subtitle = _getHumanSubtitle(log);
    final time = DateFormat('MMM dd, hh:mm a').format(log.timestamp);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildActionIcon(log.actionType),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () => _showLogDetails(context),
      ),
    );
  }

  String _getHumanAction(String action) {
    switch (action) {
      case 'Master Catalog Seeded':
        return 'System Initialized';
      case 'New Delivery':
        return 'Stock Delivery';
      case 'Physical Count Started':
        return 'Inventory Audit Started';
      case 'Physical Count Discrepancy':
        return 'Inventory Correction';
      default:
        return action;
    }
  }

  String _getHumanSubtitle(AuditLogData log) {
    if (log.afterSnapshot != null) {
      try {
        final data = jsonDecode(log.afterSnapshot!);
        if (log.actionType == 'New Delivery') {
          return 'Received ${data['itemCount']} items from ${data['supplier']}';
        }
        if (log.actionType == 'Master Catalog Seeded') {
          return 'Base product catalog successfully loaded';
        }
      } catch (_) {}
    }
    return 'Action performed on ${log.targetType}';
  }

  Widget _buildActionIcon(String actionType) {
    IconData icon;
    Color color;

    switch (actionType) {
      case 'New Delivery':
      case 'Stock In':
        icon = Icons.local_shipping_outlined;
        color = Colors.blue;
        break;
      case 'Physical Count Discrepancy':
        icon = Icons.rule_rounded;
        color = Colors.orange;
        break;
      case 'Master Catalog Seeded':
        icon = Icons.auto_awesome;
        color = Colors.purple;
        break;
      default:
        icon = Icons.history_rounded;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  void _showLogDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getHumanAction(log.actionType), 
                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(DateFormat('EEEE, MMMM dd, yyyy - hh:mm a').format(log.timestamp),
                 style: const TextStyle(color: Colors.grey)),
            const Divider(height: 48),
            _buildDetailRow('Reference ID', log.targetId.substring(0, 8).toUpperCase()),
            _buildDetailRow('Category', log.targetType),
            if (log.afterSnapshot != null) ...[
              const SizedBox(height: 24),
              const Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildDataSummary(log.afterSnapshot!),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDataSummary(String jsonStr) {
    try {
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: data.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.key.toUpperCase(), style: TextStyle(fontSize: 12, color: Colors.blue.shade900, fontWeight: FontWeight.bold)),
                  Text(e.value.toString(), style: TextStyle(color: Colors.blue.shade900)),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } catch (_) {
      return Text(jsonStr);
    }
  }
}
