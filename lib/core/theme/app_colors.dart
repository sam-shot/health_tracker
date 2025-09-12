import 'package:flutter/material.dart';


class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // --- Primary Palette ---
  static const Color primary = Color(0xFF007BFF);
  static const Color primaryDark = Color(0xFF0056b3);
  static const Color primaryLight = Color(0xFF5CACEE);

  // --- Greyscale & Backgrounds ---
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFDEE2E6);

  // --- Text Colors ---
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textOnPrimary = Colors.white;

  // --- Semantic Colors ---
  static const Color error = Color(0xFFDC3545);
  static const Color success = Color(0xFF28A745);

  // --- Mood Colors (for later use) ---
  static const Color moodHappy = Color(0xFFFFD700);
  static const Color moodNeutral = Color(0xFF6C757D);
  static const Color moodTired = Color(0xFF007BFF);
}