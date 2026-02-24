// import 'package:dreamhunter/presentation/game_screen.dart';

import 'package:flutter/material.dart';
import 'package:dreamhunter/presentation/widget/clickable_image.dart';
import 'package:dreamhunter/presentation/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/widget/mainbg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: -10,
            right: -22,
            child: MakeItButton(
              imagePath: 'assets/widget/profile.png',
              width: 100,
              height: 100,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent, // Make dialog background transparent
                      insetPadding: EdgeInsets.all(0), // Remove default padding
                      child: LoginScreen(),
                    );
                  },
                );
              },
              clickResponsiveness: true,
              onHoverGlow: true,
              isClickable: true,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/widget/dorm.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),

                  // Positioned.fill(
                  //   child: Center(
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => const GameScreen()),
                  //         );
                  //       },
                  //       child: const Icon(Icons.play_arrow),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width * 0,

            child: Image.asset(
              'assets/widget/rouletman.png',
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
