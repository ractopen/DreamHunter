import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AuthService {
  static const String _filePath = 'auth_status.json';

  static Future<Map<String, dynamic>> getAuthStatus() async {
    try {
      final file = File(_filePath);
      if (!await file.exists()) {
        await logout(); // Create the file with default values if it doesn't exist
        return {'isLoggedIn': false, 'username': null};
      }
      final contents = await file.readAsString();
      return json.decode(contents);
    } catch (e) {
      debugPrint('Error reading auth status: $e');
      return {'isLoggedIn': false, 'username': null};
    }
  }

  static Future<bool> login(String username, String password) async {
    // Check against hardcoded credentials
    if (username == 'admin' && password == 'admin123') {
      final authData = {
        'isLoggedIn': true,
        'username': 'admin',
      };
      await _writeAuthStatus(authData);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    final authData = {
      'isLoggedIn': false,
      'username': null,
    };
    await _writeAuthStatus(authData);
  }

  static Future<void> _writeAuthStatus(Map<String, dynamic> data) async {
    try {
      final file = File(_filePath);
      await file.writeAsString(json.encode(data));
    } catch (e) {
      debugPrint('Error writing auth status: $e');
    }
  }
}
