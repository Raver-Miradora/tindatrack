import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsGroup(
            'Store Identity',
            [
              const ListTile(
                leading: Icon(Icons.storefront_outlined),
                title: Text('Store Name'),
                subtitle: Text('TindaTrack Demo Store'),
              ),
              const ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('Owner Profile'),
                subtitle: Text('Default Admin'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsGroup(
            'Security',
            [
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Change Access PIN'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  TindaHaptics.selection();
                  // Implementation handled in original screen
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsGroup(
            'Maintenance',
            [
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Wipe All Data', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                subtitle: const Text('Reset inventory, sales history, and logs'),
                onTap: () => _confirmWipeData(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Center(
            child: Column(
              children: [
                Text('TindaTrack', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: -0.5)),
                Text('Production Release Candidate 1', style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 8),
                Text('Made with ❤️ for Sari-Sari Stores', style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black54, fontSize: 11, letterSpacing: 1.2)),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
          child: Column(children: children),
        ),
      ],
    );
  }

  void _confirmWipeData(BuildContext context, WidgetRef ref) {
    TindaHaptics.warning();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wipe All Data?'),
        content: const Text('This will permanently delete all products, deliveries, and counts. This action CANNOT be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => _finalConfirmation(context, ref),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Delete Everything'),
          ),
        ],
      ),
    );
  }

  void _finalConfirmation(BuildContext context, WidgetRef ref) {
    TindaHaptics.warning();
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final Warning'),
        content: const Text('Are you absolutely sure? Typing "WIPE" is required for safety in a real release, but for now, click confirm to reset.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await _executeWipe(context, ref);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('CONFIRM RESET'),
          ),
        ],
      ),
    );
  }

  Future<void> _executeWipe(BuildContext context, WidgetRef ref) async {
    TindaHaptics.success();
    final db = ref.read(databaseProvider);
    
    // In a real drift setup, we can drop and recreate or delete from all tables
    await db.transaction(() async {
      for (final table in db.allTables) {
        await db.delete(table).go();
      }
    });

    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Store data has been completely reset.')));
      context.go('/auth');
    }
  }
}
