import "package:flutter/material.dart";
import 'dart:async';
import 'dart:ui'; 
import 'package:dreamhunter/presentation/widget/loading_screen.dart';
import 'package:dreamhunter/presentation/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import firebase_auth
import 'package:dreamhunter/presentation/login_screen.dart'; // Import login_screen

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        ); // Simulate a longer splash screen
    // if (mounted) {
    //   if (FirebaseAuth.instance.currentUser != null) {
        // move here navigator
    //   } else {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => const LoginScreen()),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 5.0),
          child: Image.asset(
            'assets/widget/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 50.0,
          left: 0,
          right: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Image.asset(
                  'assets/widget/splashlogo.png',
                  width: 600.0,
                  height: 600.0,
                  color: const Color.fromARGB(255, 169, 13, 200).withAlpha((255 * 0.5).round()),
                  colorBlendMode: BlendMode.srcATop,
                ),
              ),
              Image.asset(
                'assets/widget/splashlogo.png',
                width: 600.0,
                height: 600.0,
                color: const Color.fromARGB(255, 228, 159, 240).withAlpha((255 * 0.8).round()),
                colorBlendMode: BlendMode.modulate,
              ),
            ],
          ),
        ),
        const LoadingScreen(),
      ],
    );
  }
}