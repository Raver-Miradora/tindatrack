import 'package:flutter/material.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;

  const ErrorBoundary({super.key, required this.child});

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
  }

  static void _reportError(Object error, StackTrace? stack) {
    // Future: Integration with Sentry or Firebase Crashlytics
    debugPrint('TindaTrack Crash: $error');
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),
        home: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 80, color: Colors.red),
                  const SizedBox(height: 24),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The app encountered an unexpected error. Your data is safe, but we need to restart the screen.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                        });
                      },
                      child: const Text('Try Again'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Restart the whole app logic (simple context-less reset)
                    },
                    child: const Text('Contact Support', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return _wrapChild();
  }

  Widget _wrapChild() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      _reportError(details.exception, details.stack);
      // Scheduled to avoid build-time setState
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      });
      return Container(); 
    };
    return widget.child;
  }
}

// Global Flutter Error Hook
void setupProductionErrorHandling() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Global Error caught: ${details.exception}');
  };
}
