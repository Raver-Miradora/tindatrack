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
  String? _savedPin;
  bool _isLoading = true;
  String _errorMsg = '';

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
    if (_pin.length < 4) {
      setState(() {
        _pin += value;
        _errorMsg = '';
      });
      if (_pin.length == 4) {
        _submitPin();
      }
    }
  }

  void _onDeleteTap() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _errorMsg = '';
      });
    }
  }

  Future<void> _submitPin() async {
    TindaHaptics.medium();
    final prefs = await SharedPreferences.getInstance();
    if (_savedPin == null) {
      // Setup mode: Hash and save
      final hashed = TindaSecurity.hashPin(_pin);
      await prefs.setString('owner_pin', hashed);
      ref.read(authProvider.notifier).setAuthenticated(true);
      if (mounted) context.go('/');
    } else {
      // Login mode
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
  }

  Widget _buildNumpadButton(String text) {
    return InkWell(
      onTap: () => _onKeypadTap(text),
      customBorder: const CircleBorder(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isSetup = _savedPin == null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            const Icon(Icons.storefront, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              'TindaTrack',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 32),
            Text(
              isSetup ? 'Create your 4-digit PIN' : 'Enter your PIN',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            if (_errorMsg.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                _errorMsg,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
            const Spacer(),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var i = 1; i <= 9; i++) _buildNumpadButton(i.toString()),
                    const SizedBox.shrink(), // empty space
                    _buildNumpadButton('0'),
                    InkWell(
                      onTap: _onDeleteTap,
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(Icons.backspace, size: 32, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
