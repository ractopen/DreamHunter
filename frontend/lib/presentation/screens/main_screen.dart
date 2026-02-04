import 'package:dreamdefenders/presentation/providers/message_provider.dart';
import 'package:dreamdefenders/presentation/screens/chat_screen.dart';
import 'package:dreamdefenders/presentation/screens/home_screen.dart';
import 'package:dreamdefenders/presentation/screens/leaderboard_screen.dart';
import 'package:dreamdefenders/presentation/screens/profile_screen.dart';
import 'package:dreamdefenders/presentation/screens/shop_screen.dart';
import 'package:dreamdefenders/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final bool isOnlineMode; // I'm keeping this from the placeholder
  const MainScreen({super.key, required this.isOnlineMode});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LeaderboardScreen(),
    ShopScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = MessageProvider.of(context)!;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<String>(
            valueListenable: messageProvider.message,
            builder: (context, message, child) {
                          if (message.isEmpty) { // Message should display unconditionally
                            return const SizedBox.shrink();
                          }              return Container(
                width: double.infinity,
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              );
            },
          ),
          BottomNavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
    );
  }
}