import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';

class HardElevatedButton extends StatefulWidget {
  final String label;
  final TextAlign? textAlign;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  const HardElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.textAlign,
    this.foregroundColor,
    this.backgroundColor,
    this.textColor,
  });

  const HardElevatedButton.grey({
    super.key,
    required this.onPressed,
    required this.label,
    this.textAlign,
  }) : foregroundColor = AppColors.backgroundSecondary,
       backgroundColor = AppColors.accent1,
       textColor = AppColors.primary;

  @override
  State<HardElevatedButton> createState() => _HardElevatedButtonState();
}

class _HardElevatedButtonState extends State<HardElevatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (widget.onPressed != null)
          ? (_) => setState(() => _isPressed = true)
          : null,
      onTapUp: (_) {
        if (widget.onPressed != null) {
          setState(() => _isPressed = false);
          widget.onPressed!();
        }
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        height: 60,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: (widget.onPressed == null)
                      ? AppColors.disabledText
                      : widget.backgroundColor ??
                            AppColors.accent1, // cor de fundo
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(""),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              bottom: _isPressed ? 0 : 4,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: (widget.onPressed == null)
                      ? AppColors.disabled
                      : widget.foregroundColor ??
                            AppColors.primary, // cor de fundo
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.label,
                  textAlign: widget.textAlign ?? TextAlign.center,
                  style: TextStyle(
                    color: (widget.onPressed == null)
                        ? AppColors.disabledText
                        : widget.textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.fredoka,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
