import 'package:flutter/material.dart';

abstract final class AppColors {
  // Dark moody palette
  static const background = Color(0xFF0D0D0F);
  static const surface = Color(0xFF1A1A2E);
  static const surfaceVariant = Color(0xFF16213E);
  static const surfaceBright = Color(0xFF222244);

  // Accents
  static const primary = Color(0xFF6C63FF);
  static const primaryMuted = Color(0xFF4A4580);
  static const secondary = Color(0xFF00D9FF);
  static const tertiary = Color(0xFFFF6B9D);

  // Text
  static const textPrimary = Color(0xFFF0F0F5);
  static const textSecondary = Color(0xFF9898B0);
  static const textMuted = Color(0xFF5E5E78);

  // Borders & dividers
  static const border = Color(0xFF2A2A42);
  static const divider = Color(0xFF222240);

  // Status
  static const error = Color(0xFFFF5252);
  static const success = Color(0xFF4ADE80);

  // Gradients
  static const gradientPrimary = LinearGradient(
    colors: [primary, Color(0xFF9C63FF)],
  );
  static const gradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [surfaceVariant, background],
  );
  static const gradientAvatar = LinearGradient(
    colors: [primary, secondary],
  );
}
