import 'package:dreamdefenders/presentation/screens/main_screen.dart';
import 'package:dreamdefenders/services/online_status_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isOnline;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkInitialInternetStatus();
  }

  Future<void> _checkInitialInternetStatus() async {
    final hasInternet = await OnlineStatusService.checkInternet();
    if (mounted) {
      setState(() {
        _isOnline = hasInternet;
        _isLoading = false;
      });
    }
  }

  void _startNewGame(BuildContext context, bool onlineMode) {
    if (onlineMode) {
      OnlineStatusService().init(); // Initialize the singleton service
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(isOnlineMode: onlineMode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(159, 211, 125, 12),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DREAM DEFENDERS",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Color.fromARGB(255, 255, 123, 0),
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 12.2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 15),
              const Text("Checking Network..."),
            ] else ...[
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => _startNewGame(context, false),
                  child: const Text(
                    "Offline Mode",
                    style: TextStyle(
                      color: Color.fromARGB(254, 50, 13, 214),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _isOnline == true ? () => _startNewGame(context, true) : null,
                  child: Text(
                    _isOnline == true ? "Online Mode" : "Connect To Network to use",
                    style: TextStyle(
                      color: Color.fromARGB(174, 54, 141, 13),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Icon(
                _isOnline == true ? Icons.wifi : Icons.wifi_off,
                color: _isOnline == true ? Colors.green : Colors.red,
              ),
              Text(_isOnline == true ? "Connected" : "No Connection"),
            ]
          ],
        ),
      ),
    );
  }
}