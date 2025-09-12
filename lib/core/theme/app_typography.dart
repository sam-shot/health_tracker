import 'package:flutter/material.dart';
import 'package:health_tracker/core/theme/app_colors.dart';

class AppTypography {
  AppTypography._();

  static const TextStyle _base = TextStyle(
    fontFamily: 'Gilroy',
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static final TextStyle h1 = _base.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h2 = _base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h3 = _base.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle h4 = _base.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle h5 = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body1 = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body2 = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle button = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle caption = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
}
