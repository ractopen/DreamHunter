import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// A service that monitors the device's REAL internet connectivity.
class OnlineStatusService {
  // Singleton pattern
  static final OnlineStatusService _instance = OnlineStatusService._internal();
  factory OnlineStatusService() => _instance;
  OnlineStatusService._internal(); // Private constructor

  StreamSubscription<InternetStatus>? _connectivitySubscription;
  ValueNotifier<String>? _messageNotifier; // Now nullable and private

  /// Sets the ValueNotifier for the service. Must be called before init().
  void setNotifier(ValueNotifier<String> notifier) {
    _messageNotifier = notifier;
  }

  /// Starts listening for real-time connectivity changes.
  /// This should be called once when the app starts, after setNotifier().
  void init() {
    if (_messageNotifier == null) {
      debugPrint('Error: messageNotifier not set for OnlineStatusService.');
      return;
    }
    // Ensure only one subscription is active
    _connectivitySubscription?.cancel();
    _connectivitySubscription = InternetConnection().onStatusChange.listen(_updateConnectionStatus);
    // Perform an initial check
    checkInternet().then((isOnline) {
      _updateConnectionStatus(isOnline ? InternetStatus.connected : InternetStatus.disconnected);
    });
  }

  /// Updates the messageNotifier with the current connectivity status.
  void _updateConnectionStatus(InternetStatus status) {
    if (_messageNotifier == null) return; // Should not happen if setNotifier was called

    switch (status) {
      case InternetStatus.connected:
        _messageNotifier!.value = 'Online';
        break;
      case InternetStatus.disconnected:
        _messageNotifier!.value = 'Offline';
        break;
    }
    // Clears the message after 3 seconds to be less intrusive.
    Timer(const Duration(seconds: 3), () {
      if (_messageNotifier != null) {
        _messageNotifier!.value = '';
      }
    });
  }

  /// Performs a single, one-time check for internet connectivity.
  /// Returns true if connected, false otherwise.
  static Future<bool> checkInternet() async {
    return await InternetConnection().hasInternetAccess;
  }

  /// Cancels the connectivity subscription.
  /// This should be called when the service is disposed.
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null; // Clear subscription reference
  }
}
