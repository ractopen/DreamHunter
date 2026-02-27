import 'package:dreamhunter/presentation/widget/custom_snackbar.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dreamhunter/presentation/widget/clickable_image.dart';
import 'package:dreamhunter/presentation/widget/login_dialog.dart';
import 'package:dreamhunter/presentation/widget/register_dialog.dart';
import 'package:dreamhunter/presentation/widget/profile_dialog.dart';
import 'package:dreamhunter/presentation/widget/liquid_glass_dialog.dart';

enum AuthDialogType { login, register, profile }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late StreamSubscription<User?> _authStateSubscription;
  bool _isLoggedIn = false;
  AuthDialogType _currentDialogType = AuthDialogType.login;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          _isLoggedIn = user != null;
        });
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  void _showAuthDialog() {
    setState(() {
      _currentDialogType = _isLoggedIn ? AuthDialogType.profile : AuthDialogType.login;
    });

    showGeneralDialog(
      context: context,
      barrierLabel: "AuthDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Widget dialogContent;
            const double dialogWidth = 350;
            const double dialogHeight = 520;
            const double logoHeight = 250;
            const double logoOverlap = 125;

            switch (_currentDialogType) {
              case AuthDialogType.login:
                dialogContent = LoginDialog(
                  onRegisterRequested: () {
                    setDialogState(() {
                      _currentDialogType = AuthDialogType.register;
                    });
                  },
                  onLoginSuccess: () {
                    setDialogState(() {
                      _isLoggedIn = true;
                      _currentDialogType = AuthDialogType.profile;
                      showCustomSnackBar(
                        context,
                        'Login successful!',
                        type: SnackBarType.success,
                      );
                    });
                  },
                );
                break;
              case AuthDialogType.register:
                dialogContent = RegisterDialog(
                  onLoginRequested: () {
                    setDialogState(() {
                      _currentDialogType = AuthDialogType.login;
                    });
                  },
                  onRegisterSuccess: () {
                    setDialogState(() {
                      _currentDialogType = AuthDialogType.login;
                      showCustomSnackBar(
                        context,
                        'Registration successful! Please log in.',
                        type: SnackBarType.success,
                      );
                    });
                  },
                );
                break;
              case AuthDialogType.profile:
                dialogContent = ProfileDialog(
                  onLogoutRequested: () {
                    setDialogState(() {
                      _isLoggedIn = false;
                      _currentDialogType = AuthDialogType.login;
                    });
                  },
                );
                break;
            }

            String logoPath = '';
            if (_currentDialogType == AuthDialogType.login) {
              logoPath = 'assets/widget/loginLogo.png';
            } else if (_currentDialogType == AuthDialogType.register) {
              logoPath = 'assets/widget/registerLogo.png';
            }

            final double dialogX = (MediaQuery.of(context).size.width - dialogWidth) / 2;
            final double dialogY = (MediaQuery.of(context).size.height - dialogHeight) / 2;

            final double logoX = dialogX + (dialogWidth - logoHeight) / 2;
            final double logoY = dialogY - logoOverlap;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: dialogX,
                  top: dialogY,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: dialogWidth,
                        height: dialogHeight,
                        padding: const EdgeInsets.fromLTRB(20, logoOverlap + 20, 20, 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.15),
                              Colors.white.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: LiquidGlassDialog(child: dialogContent),
                      ),
                    ),
                  ),
                ),
                if (logoPath.isNotEmpty)
                  Positioned(
                    left: logoX,
                    top: logoY,
                    child: Image.asset(
                      logoPath,
                      width: logoHeight,
                      height: logoHeight,
                    ),
                  ),
              ],
            );
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: MakeItButton(
              imagePath: 'assets/widget/sandwitch.png',
              width: 45,
              height: 45,
              onTap: _showAuthDialog,
              clickResponsiveness: true,
              onHoverGlow: true,
              isClickable: true,
            ),
          ),
        ],
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset(
              'assets/widget/signage.png',
              fit: BoxFit.contain,
              width: 80,
              height: 80,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/widget/rouletman.png',
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            bottom: 0,
            right: -1,
            child: Image.asset(
              'assets/widget/shopstall.png',
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
