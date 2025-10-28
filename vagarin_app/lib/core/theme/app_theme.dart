import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  ThemeData get light {
    return ThemeData(
      fontFamily: AppFonts.nunito,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaBold,
          fontSize: 48,
          color: AppColors.secondary,
        ),
        displayMedium: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaMedium,
          fontSize: (kIsWeb) ? 32 : 24,
          color: AppColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaBold,
          fontSize: 32,
          color: AppColors.secondary,
        ),
        headlineMedium: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaMedium,
          fontSize: 24,
          color: AppColors.secondary,
        ),
        titleLarge: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaSemiBold,
          fontSize: 20,
          color: AppColors.primary,
        ),
        titleMedium: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaMedium,
          fontSize: 18,
          color: AppColors.primary,
        ),
        titleSmall: TextStyle(
          fontFamily: AppFonts.fredoka,
          fontWeight: FontWeights.fredokaRegular,
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeights.nunitoRegular,
          fontSize: 18,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeights.nunitoRegular,
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeights.nunitoLight,
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeights.nunitoSemiBold,
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primary),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontFamily: AppFonts.fredoka,
              fontWeight: FontWeights.fredokaBold,
              fontSize: 16,
            ),
          ),
          shadowColor: WidgetStateProperty.all(AppColors.accent1),
          elevation: WidgetStateProperty.resolveWith<double>((states) {
            if (states.contains(WidgetState.pressed)) {
              return 0;
            }
            return 2;
          }),

          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.link,
          textStyle: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondary,
          side: BorderSide(color: AppColors.secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        iconColor: AppColors.accent1,
        prefixIconColor: AppColors.accent2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: TextStyle(
          fontFamily: AppFonts.nunito,
          color: AppColors.textSecondary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: CircleBorder(),
      ),
      iconTheme: IconThemeData(color: AppColors.primary),
      dividerColor: AppColors.accent1,
      dividerTheme: DividerThemeData(color: AppColors.accent1, thickness: 0.75),
      dialogTheme: DialogThemeData(backgroundColor: Colors.white),
    );
  }
}
