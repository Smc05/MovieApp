import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Movie Card Text Styles
  static const TextStyle movieTitle = TextStyle(
    fontSize: AppConstants.fontSizeLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: AppConstants.fontSizeSmall,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Detail Screen Text Styles
  static const TextStyle detailTitle = TextStyle(
    fontSize: AppConstants.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: AppConstants.detailTitleLineHeight,
  );

  static const TextStyle detailRating = TextStyle(
    fontSize: AppConstants.fontSizeXXLarge,
    color: AppColors.ratingGold,
  );

  static const TextStyle infoLabel = TextStyle(
    fontSize: AppConstants.fontSizeSmall,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle infoValue = TextStyle(
    fontSize: AppConstants.fontSizeXLarge,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle genreTag = TextStyle(
    color: Colors.white,
    fontSize: AppConstants.fontSizeMedium,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle synopsis = TextStyle(
    fontSize: AppConstants.fontSizeLarge,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  // Error Text Styles
  static const TextStyle errorTitle = TextStyle(
    fontSize: AppConstants.fontSizeXXLarge,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle errorMessage = TextStyle(
    color: AppColors.textSecondary,
  );

  // Rating Text Styles
  static const TextStyle ratingValue = TextStyle(
    fontSize: AppConstants.fontSizeMedium,
    fontWeight: FontWeight.w600,
    color: AppColors.ratingGold,
  );

  static const TextStyle likeValue = TextStyle(
    fontSize: AppConstants.fontSizeMedium,
    fontWeight: FontWeight.w600,
    color: AppColors.specialColor,
  );
}
