// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Основной кислотно-зелёный (яркий неоновый)
  static const primary = Color(0xFF00FF00); // чистый зелёный

  // Вариации для глубины
  static const primaryLight = Color(0xFF80FF80); // светлый зелёный
  static const primaryDark = Color(0xFF00CC00); // тёмный зелёный

  // Акцентные цвета
  static const accentPurple = Color(
    0xFFAA00FF,
  ); // фиолетовый (дополняет зелёный)
  static const accentBlue = Color(0xFF00CCFF); // голубой

  // Нейтральные фоны
  static const backgroundLight = Color(0xFFF5F5F5); // светлый фон
  static const surfaceLight = Colors.white; // белая поверхность
  static const surfaceDark = Color(
    0xFF1E1E1E,
  ); // тёмная поверхность (для тёмной темы)

  // Текст
  static const textPrimary = Color(0xFF212121); // основной текст
  static const textSecondary = Color(0xFF757575); // второстепенный текст

  // Статусы
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
  static const warning = Color(0xFFFFB300);
}
