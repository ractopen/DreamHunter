import 'package:dreamdefenders/presentation/widgets/nav_button.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavButton(
            icon: Icons.home,
            label: 'Home',
            isSelected: selectedIndex == 0,
            onPressed: () => onItemTapped(0),
          ),
          NavButton(
            icon: Icons.emoji_events,
            label: 'Leaderboard',
            isSelected: selectedIndex == 1,
            onPressed: () => onItemTapped(1),
          ),
          NavButton(
            icon: Icons.shopping_cart,
            label: 'Shop',
            isSelected: selectedIndex == 2,
            onPressed: () => onItemTapped(2),
          ),
          NavButton(
            icon: Icons.chat_bubble,
            label: 'Chat',
            isSelected: selectedIndex == 3,
            onPressed: () => onItemTapped(3),
          ),
          NavButton(
            icon: Icons.person,
            label: 'Profile',
            isSelected: selectedIndex == 4,
            onPressed: () => onItemTapped(4),
          ),
        ],
      ),
    );
  }
}
