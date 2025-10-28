import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class HardCircularButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Icon icon;

  const HardCircularButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<HardCircularButton> createState() => _HardCircularButtonState();
}

class _HardCircularButtonState extends State<HardCircularButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        height: 64,
        width: 56,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.accent1, // sombra dura
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              bottom: _isPressed ? 0 : 4,
              left: 0,
              right: 0,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Icon(widget.icon.icon, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
