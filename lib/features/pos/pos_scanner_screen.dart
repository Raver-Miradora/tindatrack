import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:intl/intl.dart';

import 'pos_cart_provider.dart';
import 'widgets/pos_checkout_dialog.dart';
import 'widgets/pos_checkout_utang_dialog.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

class PosScannerScreen extends ConsumerStatefulWidget {
  const PosScannerScreen({super.key});

  @override
  ConsumerState<PosScannerScreen> createState() => _PosScannerScreenState();
}

class _PosScannerScreenState extends ConsumerState<PosScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  bool _isLocked = false;
  Timer? _unlockTimer;

  @override
  void dispose() {
    _unlockTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isLocked || !mounted) return;
    final barcodeValue = capture.barcodes.first.rawValue;
    if (barcodeValue == null) return;

    setState(() => _isLocked = true);

    final db = ref.read(databaseProvider);
    final product = await (db.select(db.products)..where((p) => p.barcode.equals(barcodeValue))).getSingleOrNull();

    if (product != null && mounted) {
      TindaHaptics.success();
      ref.read(posCartProvider.notifier).addScannedProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${product.name}'), duration: const Duration(milliseconds: 1000)));
    } else if (mounted) {
      TindaHaptics.warning();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product not found'), backgroundColor: Colors.red));
    }

    _unlockTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isLocked = false);
    });
  }

  void _handleCheckout() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PosCheckoutDialog(),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Payment Successful!',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green));
    }
  }

  void _handleUtangCheckout() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PosCheckoutUtangDialog(),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Utang Logged Successfully!',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.orange));
    }
  }

  void _showMiscDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.add_circle_outline, color: Colors.teal),
            SizedBox(width: 8),
            Text('Misc / Tingi Item', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Halaga (Amount)',
            prefixText: 'PHP ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              final amount = double.tryParse(controller.text.trim());
              if (amount != null && amount > 0) {
                ref.read(posCartProvider.notifier).addMiscItem(amount);
                TindaHaptics.success();
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(posCartProvider);
    final total = ref.watch(posCartTotalProvider);
    final currencyFormat = NumberFormat.currency(symbol: 'PHP ', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Cashier', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Clear Cart',
            onPressed: () {
              ref.read(posCartProvider.notifier).clearCart();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Half: Scanner
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                ),
                if (_isLocked)
                  Container(
                    color: Colors.black45,
                    child: const Center(
                      child: Icon(Icons.check_circle, color: Colors.green, size: 64),
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _isLocked ? 'Item Added...' : 'Ready to Scan',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Half: Cart
          Expanded(
            flex: 3,
            child: cart.isEmpty 
              ? const Center(child: Text('Scan items to add to cart', style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final item = cart[index];
                    final isMisc = item.isMisc;
                    return ListTile(
                      tileColor: isMisc ? Colors.amber.shade50 : null,
                      title: Row(
                        children: [
                          if (isMisc)
                            const Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: Icon(Icons.add_circle_outline, size: 16, color: Colors.teal),
                            ),
                          Text(item.product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isMisc ? Colors.teal.shade700 : null)),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(isMisc
                              ? 'PHP ${(item.product.averageSellingPrice ?? 0).toStringAsFixed(2)} (tingi)'
                              : '${currencyFormat.format(item.product.averageSellingPrice ?? 0)} x ${item.quantity}'),
                          if (!isMisc && item.quantity > item.product.currentStock)
                            Text(
                              'Warning: Only ${item.product.currentStock.toInt()} in stock',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      trailing: isMisc
                          ? IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () =>
                                  ref.read(posCartProvider.notifier).remove(item.product.id),
                            )
                          : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => ref.read(posCartProvider.notifier).decrement(item.product.id),
                          ),
                          Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => ref.read(posCartProvider.notifier).increment(item.product.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(
                    currencyFormat.format(total),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.blue),
                  ),
                ],
              ),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    // Misc / Tingi Item button
                    OutlinedButton.icon(
                      onPressed: _showMiscDialog,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Misc', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        foregroundColor: Colors.teal,
                        side: const BorderSide(color: Colors.teal, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: cart.isEmpty ? null : _handleUtangCheckout,
                      icon: const Icon(Icons.receipt_long),
                      label: const Text('I-Utang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: cart.isEmpty ? null : _handleCheckout,
                      icon: const Icon(Icons.payment),
                      label: const Text('Charge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
