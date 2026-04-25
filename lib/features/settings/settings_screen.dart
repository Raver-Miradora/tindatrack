import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_controller.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final currentName = ref.read(storeNameProvider);
    _nameController = TextEditingController(text: currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        title: const Text('Settings & Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildBrandingSection(),
          const SizedBox(height: 32),
          const Text('Inventory Management', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 16),
          _buildActionCard(
            context,
            icon: Icons.delete_forever_rounded,
            color: Colors.red,
            title: 'Wipe All Data',
            subtitle: 'Delete all products, stock history, and logs',
            onTap: () => _confirmWipe(context, ref),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            context,
            icon: Icons.backup_rounded,
            color: Colors.blue,
            title: 'Export Data',
            subtitle: 'Generate a CSV report of current stock',
            onTap: () {
              TindaHaptics.light();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting CSV... (Future Feature)')));
            },
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text('TindaTrack v1.0.0-RC\nDesigned for Sari-Sari Success', 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandingSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Store Branding', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 4),
          const Text('This name appears on your dashboard and reports', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Store Name',
              hintText: 'Enter your store name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              prefixIcon: const Icon(Icons.storefront_rounded),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                TindaHaptics.success();
                await ref.read(storeNameProvider.notifier).updateName(_nameController.text);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Branding updated!')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {required IconData icon, required Color color, required String title, required String subtitle, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        onTap: onTap,
      ),
    );
  }

  void _confirmWipe(BuildContext context, WidgetRef ref) {
    TindaHaptics.warning();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wipe All Data?'),
        content: const Text('This action is permanent. You will lose all inventory counts, delivery history, and custom products. Your store name will also reset.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              TindaHaptics.success();
              final db = ref.read(databaseProvider);
              await db.transaction(() async {
                await db.delete(db.stockInItems).go();
                await db.delete(db.stockInEvents).go();
                await db.delete(db.countItems).go();
                await db.delete(db.countSessions).go();
                await db.delete(db.auditLog).go();
                await db.delete(db.products).go();
              });
              await ref.read(storeNameProvider.notifier).updateName('TindaTrack');
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All data wiped successfully.')));
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Yes, Wipe Everything'),
          ),
        ],
      ),
    );
  }
}
