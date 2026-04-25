import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider must be overridden in ProviderScope');
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in ProviderScope');
});

/// Session-based authentication state. 
/// Resets to false when the app process is terminated.
class AuthNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setAuthenticated(bool value) {
    state = value;
  }
}

final authProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);
