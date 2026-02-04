import 'package:dreamdefenders/presentation/screens/next_page.dart';
import 'package:dreamdefenders/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = false;
  String? _username;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    // No need to show a loading indicator here unless we want to rebuild the whole page
    final authStatus = await AuthService.getAuthStatus();
    if (mounted) {
      setState(() {
        _isLoggedIn = authStatus['isLoggedIn'];
        _username = authStatus['username'];
        _isLoading = false; // Done loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dream Hunters"),
        actions: [
          // Refresh button to demonstrate reactivity
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAuthStatus,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_isLoggedIn)
              Text(
                'Welcome, $_username!',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            else
              Text(
                'Not Logged In',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: const Text('Play!'),
            ),
          ],
        ),
      ),
    );
  }
}