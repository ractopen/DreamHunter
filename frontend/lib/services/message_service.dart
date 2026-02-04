import 'dart:async';

import 'package:dreamdefenders/presentation/providers/message_provider.dart';
import 'package:flutter/material.dart';

class MessageService {
  static Timer? _timer;

  static void showMessage(BuildContext context, String message) {
    // Cancel any existing timer
    _timer?.cancel();

    final messageProvider = MessageProvider.of(context);
    if (messageProvider != null) {
      messageProvider.message.value = message;

      // Set a timer to clear the message after 5 seconds
      _timer = Timer(const Duration(seconds: 5), () {
        messageProvider.message.value = '';
      });
    }
  }
}
