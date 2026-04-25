import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/database/database.dart';
import 'core/database/seed_data.dart';
import 'core/router.dart';
import 'core/theme.dart';
import 'core/providers.dart';
import 'core/logic/background_tasks.dart';
import 'features/settings/settings_controller.dart';

void main() async {
  // HARDENING: Global Error Handling to prevent silent crashes
  WidgetsFlutterBinding.ensureInitialized();
  
  // Catch Flutter Errors (Widget build errors, etc.)
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // Future: Log to Sentry/Crashlytics
  };

  // Catch Platform Errors (Async/Native crashes)
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('GLOBAL ERROR: $error');
    return true; // Prevent app from closing
  };

  // Initialize Preferences & Background Tasks
  final prefs = await SharedPreferences.getInstance();
  await BackgroundTaskService.init();
  await BackgroundTaskService.scheduleDailyAudit();

  // Initialize Database and Seed Data
  final db = AppDatabase();
  await seedDatabase(db);

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const TindaTrackApp(),
    ),
  );
}

class TindaTrackApp extends ConsumerWidget {
  const TindaTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeName = ref.watch(storeNameProvider);

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: storeName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      // Hardening: Custom Error Widget for the "Red Screen of Death"
      builder: (context, widget) {
        ErrorWidget.builder = (details) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text('Something went wrong', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('TindaTrack encountered an unexpected error. Please restart the app.', textAlign: TextAlign.center),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  child: const Text('Return to Home'),
                )
              ],
            ),
          ),
        );
        return widget!;
      },
    );
  }
}
