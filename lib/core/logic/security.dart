import 'package:crypto/crypto.dart';
import 'dart:convert';

class TindaSecurity {
  /// Hashes a PIN using SHA-256 with a static salt for production hardening.
  /// This ensures that even if the Drift database is leaked, the plain PIN is not exposed.
  static String hashPin(String pin) {
    const salt = "TindaTrack_Retail_2026_Secure";
    final bytes = utf8.encode(pin + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verifies a plain PIN against a stored hash.
  static bool verifyPin(String plainPin, String storedHash) {
    return hashPin(plainPin) == storedHash;
  }
}
