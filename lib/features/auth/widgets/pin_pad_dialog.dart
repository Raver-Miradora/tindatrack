import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/logic/security.dart';
import '../../../core/logic/haptics.dart';

class PinPadDialog extends StatefulWidget {
  final VoidCallback onSuccess;
  final String title;

  const PinPadDialog({
    super.key,
    required this.onSuccess,
    this.title = 'Enter Master PIN',
  });

  @override
  State<PinPadDialog> createState() => _PinPadDialogState();
}

class _PinPadDialogState extends State<PinPadDialog> {
  String _pin = '';
  String _errorMsg = '';
  bool _isChecking = false;

  void _onKeypadTap(String value) {
    if (_pin.length < 4 && !_isChecking) {
      setState(() {
        _pin += value;
        _errorMsg = '';
      });
      if (_pin.length == 4) {
        _verifyPin();
      }
    }
  }

  void _onDeleteTap() {
    if (_pin.isNotEmpty && !_isChecking) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Future<void> _verifyPin() async {
    setState(() {
      _isChecking = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final savedPinHash = prefs.getString('owner_pin');

    if (savedPinHash == null) {
      // Edge case: No PIN set somehow, shouldn't happen but just in case
      TindaHaptics.success();
      widget.onSuccess();
      return;
    }

    if (TindaSecurity.verifyPin(_pin, savedPinHash)) {
      TindaHaptics.success();
      widget.onSuccess();
    } else {
      TindaHaptics.warning();
      setState(() {
        _errorMsg = 'Incorrect PIN';
        _pin = '';
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock_person_outlined, size: 48, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length
                        ? Colors.green
                        : Colors.grey.shade200,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            if (_errorMsg.isNotEmpty)
              Text(
                _errorMsg,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            else
              const SizedBox(height: 16),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var i = 1; i <= 9; i++) _buildNumpadButton(i.toString()),
                const SizedBox.shrink(),
                _buildNumpadButton('0'),
                _buildDeleteButton(),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumpadButton(String text) {
    return InkWell(
      onTap: () => _onKeypadTap(text),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _onDeleteTap,
      borderRadius: BorderRadius.circular(50),
      child: const Center(
        child: Icon(Icons.backspace_outlined, size: 24, color: Colors.grey),
      ),
    );
  }
}
