import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delivery_controller.dart';
import '../../../core/database/database.dart';
import '../../../core/logic/haptics.dart';

class ScanItemBottomSheet extends ConsumerStatefulWidget {
  final Product product;

  const ScanItemBottomSheet({super.key, required this.product});

  @override
  ConsumerState<ScanItemBottomSheet> createState() =>
      _ScanItemBottomSheetState();
}

class _ScanItemBottomSheetState extends ConsumerState<ScanItemBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Delivery (add) fields
  final _deliveryQtyController = TextEditingController(text: '1');
  final _deliveryCostController = TextEditingController();
  final _deliveryPriceController = TextEditingController();

  // Count (set) fields
  final _countQtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Pre-fill with current product values
    _deliveryCostController.text =
        widget.product.averageCost.toStringAsFixed(2);
    _deliveryPriceController.text =
        (widget.product.averageSellingPrice ?? 0).toInt().toString();
    _countQtyController.text =
        widget.product.currentStock.toInt().toString();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _deliveryQtyController.dispose();
    _deliveryCostController.dispose();
    _deliveryPriceController.dispose();
    _countQtyController.dispose();
    super.dispose();
  }

  void _commit() {
    final isDelivery = _tabController.index == 0;
    TindaHaptics.success();

    if (isDelivery) {
      final qty =
          double.tryParse(_deliveryQtyController.text.trim()) ?? 1.0;
      final cost =
          double.tryParse(_deliveryCostController.text.trim()) ??
              widget.product.averageCost;
      final price =
          (double.tryParse(_deliveryPriceController.text.trim()) ??
                  (widget.product.averageSellingPrice ?? 0))
              .roundToDouble();

      ref.read(deliveryCartProvider.notifier).addItem(
            product: widget.product,
            quantity: qty,
            unitCost: cost,
            unitSellingPrice: price,
            operation: InventoryOperation.add,
          );
    } else {
      final qty =
          double.tryParse(_countQtyController.text.trim()) ??
              widget.product.currentStock;

      ref.read(deliveryCartProvider.notifier).addItem(
            product: widget.product,
            quantity: qty,
            unitCost: widget.product.averageCost,
            unitSellingPrice: widget.product.averageSellingPrice ?? 0.0,
            operation: InventoryOperation.set,
          );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Product header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Current stock: ${widget.product.currentStock.toInt()} ${widget.product.unit}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade600,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                indicator: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: '📦  Tanggap Delivery'),
                  Tab(text: '🔢  Mano-manong Bilang'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Tab content — fixed height to avoid layout jumps
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // ── Tab 1: Delivery (ADD) ─────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _deliveryQtyController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                autofocus: true,
                                decoration: InputDecoration(
                                  labelText: 'Qty Received',
                                  prefixIcon:
                                      const Icon(Icons.add_box_outlined),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _deliveryCostController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: InputDecoration(
                                  labelText: 'Unit Cost (₱)',
                                  prefixIcon:
                                      const Icon(Icons.shopping_bag_outlined),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _deliveryPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Selling Price (₱)',
                            prefixIcon: const Icon(Icons.sell_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Tab 2: Physical Count (SET) ───────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ilagay ang aktwal na bilang sa bodega.',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _countQtyController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true),
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'Actual Count',
                            suffixText: widget.product.unit,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.orange.shade700, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Confirm button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: ElevatedButton.icon(
                onPressed: _commit,
                icon: const Icon(Icons.check_rounded),
                label: const Text('I-dagdag sa Cart',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
