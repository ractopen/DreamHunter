import 'package:dreamdefenders/presentation/providers/message_provider.dart';
import 'package:dreamdefenders/presentation/screens/splash_screen.dart';
import 'package:dreamdefenders/services/online_status_service.dart'; // Import the service
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final messageNotifier = ValueNotifier<String>('');

  // Set the notifier for the singleton service
  OnlineStatusService().setNotifier(messageNotifier);

  runApp(
    MessageProvider(
      message: messageNotifier,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}