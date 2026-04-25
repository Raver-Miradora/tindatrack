import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';

class StoreNameNotifier extends Notifier<String> {
  static const _key = 'store_name';
  static const _default = 'TindaTrack';

  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_key) ?? _default;
  }

  Future<void> updateName(String newName) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, newName);
    state = newName;
  }
}

final storeNameProvider = NotifierProvider<StoreNameNotifier, String>(StoreNameNotifier.new);
