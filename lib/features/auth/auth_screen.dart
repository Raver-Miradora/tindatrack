import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/logic/security.dart';
import '../../core/providers.dart';
import '../../core/logic/haptics.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  String _pin = '';
  String _confirmPin = '';
  String? _savedPin;
  bool _isLoading = true;
  String _errorMsg = '';
  bool _isConfirming = false;

  @override
  void initState() {
    super.initState();
    _checkSavedPin();
  }

  Future<void> _checkSavedPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedPin = prefs.getString('owner_pin');
      _isLoading = false;
    });
  }

  void _onKeypadTap(String value) {
    if (_isConfirming) {
      if (_confirmPin.length < 4) {
        setState(() {
          _confirmPin += value;
          _errorMsg = '';
        });
        if (_confirmPin.length == 4) {
          _submitSetup();
        }
      }
    } else {
      if (_pin.length < 4) {
        setState(() {
          _pin += value;
          _errorMsg = '';
        });
        if (_pin.length == 4) {
          if (_savedPin == null) {
            setState(() {
              _isConfirming = true;
              _errorMsg = '';
            });
          } else {
            _submitLogin();
          }
        }
      }
    }
  }

  void _onDeleteTap() {
    if (_isConfirming) {
      if (_confirmPin.isNotEmpty) {
        setState(() => _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1));
      } else {
        setState(() => _isConfirming = false);
      }
    } else if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  Future<void> _submitLogin() async {
    TindaHaptics.medium();
    if (TindaSecurity.verifyPin(_pin, _savedPin!)) {
      ref.read(authProvider.notifier).setAuthenticated(true);
      if (mounted) context.go('/');
    } else {
      TindaHaptics.warning();
      setState(() {
        _errorMsg = 'Incorrect PIN';
        _pin = '';
      });
    }
  }

  Future<void> _submitSetup() async {
    TindaHaptics.medium();
    if (_pin == _confirmPin) {
      final prefs = await SharedPreferences.getInstance();
      final hashed = TindaSecurity.hashPin(_pin);
      await prefs.setString('owner_pin', hashed);
      ref.read(authProvider.notifier).setAuthenticated(true);
      if (mounted) context.go('/');
    } else {
      TindaHaptics.warning();
      setState(() {
        _errorMsg = 'PINs do not match. Try again.';
        _pin = '';
        _confirmPin = '';
        _isConfirming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isSetup = _savedPin == null;
    final currentPin = _isConfirming ? _confirmPin : _pin;
    final title = isSetup 
        ? (_isConfirming ? 'Confirm your PIN' : 'Set up your Security PIN')
        : 'Enter your PIN';

    return Scaffold(
      backgroundColor: Colors.white,
      // CRITICAL: Without resizeToAvoidBottomInset, the numpad clips off screen
      // on any Android device with a soft keyboard active (e.g. external keyboard
      // connected, or accessibility overlay). Setting true lets the Scaffold
      // compress its body to fit above the keyboard inset.
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock_person_outlined, size: 64, color: Colors.green),
            ),
            const SizedBox(height: 24),
            Text(
              'TindaTrack Security',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < currentPin.length
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
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var i = 1; i <= 9; i++) _buildNumpadButton(i.toString()),
                  const SizedBox.shrink(),
                  _buildNumpadButton('0'),
                  _buildDeleteButton(),
                ],
              ),
            ),
            const SizedBox(height: 48),
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
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _onDeleteTap,
      borderRadius: BorderRadius.circular(50),
      child: const Center(
        child: Icon(Icons.backspace_outlined, size: 28, color: Colors.grey),
      ),
    );
  }
}
