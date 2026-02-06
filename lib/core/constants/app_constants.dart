class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Info
  static const String appName = 'Movie App';

  // API
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;

  // Movie Card Dimensions
  static const double movieCardHeight = 160.0;
  static const double movieCardTopMargin = 30.0;
  static const double movieCardPosterOverflow = -30.0;
  static const double movieCardContentLeftPadding = 140.0;
  static const double moviePosterWidth = 100.0;
  static const double moviePosterHeight = 150.0;

  // Icon Sizes
  static const double iconSizeSmall = 12.0;
  static const double iconSizeMedium = 14.0;
  static const double iconSizeLarge = 24.0;
  static const double iconSizeXLarge = 48.0;
  static const double iconSizeXXLarge = 64.0;

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 13.0;
  static const double fontSizeLarge = 14.0;
  static const double fontSizeXLarge = 16.0;
  static const double fontSizeXXLarge = 18.0;
  static const double fontSizeTitle = 32.0;

  // Like Icon
  static const double likeIconSize = 20.0;

  // Shadow
  static const double shadowBlurRadius = 10.0;
  static const double shadowOffsetY = 4.0;
  static const double shadowOpacity = 0.15;

  // Divider
  static const double dividerWidth = 1.0;
  static const double dividerHeight = 40.0;

  // Genre Tag
  static const double genreTagSpacing = 10.0;
  static const double genreTagPaddingHorizontal = 8.0;
  static const double genreTagPaddingVertical = 4.0;

  // Detail Screen
  static const double detailPosterHeightRatio = 0.6;
  static const double detailBackButtonTop = 8.0;
  static const double detailBackButtonLeft = 16.0;
  static const double detailBackButtonSize = 28.0;
  static const double detailTitleBottom = 30.0;
  static const double detailTitleHorizontal = 20.0;
  static const double detailTitleLineHeight = 1.2;

  // Popularity Threshold
  static const int popularityThousandThreshold = 1000;

  // Loading
  static const double loadingIndicatorStrokeWidth = 2.0;
}
