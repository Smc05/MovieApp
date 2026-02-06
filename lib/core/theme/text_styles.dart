import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Movie Card Specific
  static const TextStyle movieTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
