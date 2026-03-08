import 'package:flutter/material.dart';

/// A highly interactive, animated image-based button for indie game UIs.
/// Supports hover scaling, click feedback, and a glow effect.
///
/// ### How to use:
/// ```dart
/// MakeItButton(
///   imagePath: 'assets/images/dashboard/sandwich.png',
///   onTap: () => print('Button Tapped!'),
///   width: 50,
///   height: 50,
///   onHoverGlow: true,
/// )
/// ```
class MakeItButton extends StatefulWidget {
  /// Path to the asset image.
  final String imagePath;

  /// Callback function when the button is tapped.
  final VoidCallback? onTap;

  /// Width of the button.
  final double width;

  /// Height of the button.
  final double height;

  /// Whether the button scales down slightly when pressed.
  final bool clickResponsiveness;

  /// Whether a white glow appears behind the image on hover.
  final bool onHoverGlow;

  /// Whether the button is currently interactive.
  final bool isClickable;

  const MakeItButton({
    super.key,
    required this.imagePath,
    this.onTap,
    this.width = 50,
    this.height = 50,
    this.clickResponsiveness = true,
    this.onHoverGlow = true,
    this.isClickable = true,
  });

  @override
  State<MakeItButton> createState() => _MakeItButtonState();
}

class _MakeItButtonState extends State<MakeItButton> {
  bool _isHovering = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isClickable && widget.clickResponsiveness
          ? (_) => setState(() => _isTapped = true)
          : null,
      onTapUp: widget.isClickable && widget.clickResponsiveness
          ? (_) => setState(() => _isTapped = false)
          : null,
      onTapCancel: widget.isClickable && widget.clickResponsiveness
          ? () => setState(() => _isTapped = false)
          : null,
      onTap: widget.isClickable ? widget.onTap : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedScale(
          scale: (widget.clickResponsiveness && (_isHovering || _isTapped))
              ? 1.1
              : 1.0,
          duration: const Duration(milliseconds: 100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: widget.onHoverGlow && (_isHovering || _isTapped)
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withAlpha((255 * 0.8).round()),
                        blurRadius: 25.0,
                        spreadRadius: 1.0,
                        offset: Offset.zero,
                      ),
                    ],
                  )
                : null,
            child: Image.asset(
              widget.imagePath,
              width: widget.width,
              height: widget.height,
            ),
          ),
        ),
      ),
    );
  }
}
