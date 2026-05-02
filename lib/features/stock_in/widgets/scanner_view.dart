import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  // One fresh controller per route instance. Created in the State class (not in
  // build()) so it is guaranteed to be a new, independent instance on every
  // route push, with no shared state from a previous session.
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  // Atomic lock: set to true the moment a valid barcode is accepted.
  // Prevents the 30fps frame stream from queuing multiple pop() calls.
  bool _isLocked = false;

  @override
  void dispose() {
    // dispose() runs on the Flutter UI thread AFTER the route pop animation
    // completes and the widget is fully removed from the tree. This is the
    // safe, non-deadlocking teardown path for the native camera resources.
    _controller.dispose();
    super.dispose();
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    // Guard 1: if we've already accepted a barcode, ignore all further frames.
    if (_isLocked) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null) return;

    // Guard 2: check mounted BEFORE setting _isLocked.
    // 
    // Critical ordering: if we set _isLocked = true first and then discover
    // mounted == false, the lock is permanently engaged. The user would
    // re-open the scanner, scan an item, and nothing would happen — a "ghost
    // scanner" that appears active but is silently bricked.
    //
    // By checking mounted first, we guarantee _isLocked is only committed when
    // we know the pop() will actually execute.
    if (!mounted) return;

    _isLocked = true;
    Navigator.pop(context, code);

    // NOTE: Do NOT call _controller.stop() here.
    // stop() tries to join the native Android HandlerThread, but onDetect
    // is invoked FROM that thread. Calling stop() here is a self-deadlock.
    // The camera is released safely via dispose() above.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Scan Product Barcode',
            style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onBarcodeDetected,
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 48,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: Icons.flash_on,
            onTap: () => _controller.toggleTorch(),
          ),
          _buildControlButton(
            icon: Icons.flip_camera_ios,
            onTap: () => _controller.switchCamera(),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}
