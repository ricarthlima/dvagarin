import 'package:flutter/material.dart';

final class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0288D1); // Azul médio forte
  static const Color secondary = Color(0xFF01579B); // Azul profundo

  // Cores de destaque usando tons claros e vibrantes da maçã
  static const Color accent1 = Color(0xFF4FC3F7); // Azul claro vibrante
  static const Color accent2 = Color(0xFF0277BD); // Azul escuro mais saturado

  // Fundo claro que harmoniza com os azuis
  static const Color background = Color(
    0xFFF5F9FC,
  ); // Azul muito claro quase branco

  static const Color backgroundSecondary = Color(0xFFe9f1f7);

  // Texto com bom contraste
  static const Color textPrimary = Color(
    0xFF142538,
  ); // Azul-marinho quase preto
  static const Color textSecondary = Color(0xFF546E7A); // Cinza-azulado suave

  // Links usando o azul mais vibrante
  static const Color link = Color(0xFF0288D1);

  // Estados de feedback
  static const Color error = Color(0xFFD32F2F); // Vermelho padrão
  static const Color success = Color(0xFF2E7D32); // Verde positivo

  // Estados desabilitados
  static const Color disabled = Color(0xFFE0E0E0); // Cinza claro
  static const Color disabledText = Color(0xFF9E9E9E); // Cinza médio

  // Gradiente principal com dois tons da maçã
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, accent1],
  );

  static const googleAuthBorderLight = Color(0xff747775);
  static const googleAuthBorderDark = Color(0xff8E918F);
  static const googleAuthTextDark = Color(0xffE3E3E3);
  static const googleAuthTextLight = Color(0xff1F1F1F);
  static const googleAuthFillLight = Color(0xFFFFFFFF);
  static const googleAuthFillDark = Color(0xFF131314);
}
