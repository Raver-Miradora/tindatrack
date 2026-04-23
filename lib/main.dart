import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database.dart';
import 'core/database/seed_data.dart';
import 'core/router.dart';
import 'core/theme.dart';
import 'core/providers.dart';
import 'core/logic/background_tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Background Tasks
  await BackgroundTaskService.init();
  await BackgroundTaskService.scheduleDailyAudit();

  // Initialize Database and Seed Data
  final db = AppDatabase();
  await DatabaseSeeder.seedInitialData(db);

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
      child: const TindaTrackApp(),
    ),
  );
}

class TindaTrackApp extends ConsumerWidget {
  const TindaTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'TindaTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
    );
  }
}
