import 'package:flutter/services.dart';

class TindaHaptics {
  /// Light click for selection changes or minor adjustments.
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// Medium impact for primary actions like "Save" or "Finalize".
  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
  }

  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact or double-tap for warnings or errors.
  static Future<void> warning() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.heavyImpact();
  }

  /// Lightest feedback for rapid interactions like scrolling or typing.
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }
}
