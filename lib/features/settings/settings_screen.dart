import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsGroup(
            'Account & Security',
            [
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Change Owner PIN'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showChangePinDialog(context),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => context.go('/auth'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsGroup(
            'Maintenance',
            [
               ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Wipe All Data', style: TextStyle(color: Colors.red)),
                subtitle: const Text('Clear inventory, logs, and sessions'),
                onTap: () {
                  // TODO: Confirmation dialog
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: Column(
              children: [
                Text('TindaTrack MVP', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Version 1.0.0 (Phase 4)', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showChangePinDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change PIN'),
        content: TextField(
          controller: controller,
          obscureText: true,
          maxLength: 4,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'New 4-digit PIN'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.length == 4) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('owner_pin', controller.text);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN updated successfully')));
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
