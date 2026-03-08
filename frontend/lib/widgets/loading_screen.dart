import 'package:flutter/material.dart';

/// A reusable loading bar widget that displays progress.
///
/// ### How to use:
/// ```dart
/// LoadingScreen(progress: 0.5) // Displays 50%
/// ```
class LoadingScreen extends StatefulWidget {
  final double progress;

  const LoadingScreen({super.key, this.progress = 0.0});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 229, 46, 246)
                        .withValues(alpha: 0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: RotationTransition(
                turns: _rotationController,
                child: Image.asset(
                  'assets/images/dashboard/small_circle_figure.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 28.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3.0),
                ),
                child: LinearProgressIndicator(
                  value: widget.progress,
                  minHeight: 20.0,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 203, 28, 197),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 50,
              child: Text(
                '${(widget.progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 188, 173, 173),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
