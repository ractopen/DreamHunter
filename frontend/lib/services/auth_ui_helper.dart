import 'package:flutter/material.dart';

/// A helper class to standardize the look and validation of Auth-related forms.
///
/// Use this to ensure all your input fields have a consistent indie-game style.
class AuthUIHelper {
  /// Returns a standard [InputDecoration] for the game's auth forms.
  ///
  /// ### How to use:
  /// ```dart
  /// TextFormField(
  ///   decoration: AuthUIHelper.inputDecoration('Email'),
  /// )
  /// ```
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.7)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  /// Validates that an email is present and properly formatted.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  /// Validates that a password is present and at least 6 characters long.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
