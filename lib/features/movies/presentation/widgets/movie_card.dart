import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/movie.dart';
import 'movie_poster.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: AppConstants.movieCardHeight,
      margin: const EdgeInsets.only(top: AppConstants.movieCardTopMargin),
      child: Stack(
        clipBehavior: Clip.none,
        children: [_buildCardContent(isDarkMode), _buildPosterWithHero()],
      ),
    );
  }

  Widget _buildCardContent(bool isDarkMode) {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Card(
          elevation: isDarkMode ? 0 : 2,
          color: isDarkMode ? AppColors.darkCardBackground : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppConstants.movieCardContentLeftPadding,
              right: AppConstants.paddingMedium,
              top: AppConstants.paddingMedium,
              bottom: AppConstants.paddingMedium,
            ),
            child: _buildMovieDetails(),
          ),
        ),
      ),
    );
  }

  Widget _buildPosterWithHero() {
    return Positioned(
      left: AppConstants.paddingMedium,
      top: AppConstants.movieCardPosterOverflow,
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: 'movie_${movie.id}',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(AppConstants.shadowOpacity),
                  blurRadius: AppConstants.shadowBlurRadius,
                  offset: const Offset(0, AppConstants.shadowOffsetY),
                ),
              ],
            ),
            child: _buildPoster(),
          ),
        ),
      ),
    );
  }

  Widget _buildPoster() {
    return MoviePoster(
      posterUrl: movie.fullPosterPath,
      width: AppConstants.moviePosterWidth,
      height: AppConstants.moviePosterHeight,
      borderRadius: BorderRadius.circular(AppConstants.radiusMedium - 2),
    );
  }

  Widget _buildMovieDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        const SizedBox(height: 6),
        _buildRatingAndLikes(),
        const SizedBox(height: AppConstants.paddingSmall),
        _buildOverview(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      movie.title,
      style: AppTextStyles.movieTitle.copyWith(
        fontSize: AppConstants.fontSizeXLarge,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRatingAndLikes() {
    return Row(
      children: [
        _buildRating(),
        const SizedBox(width: AppConstants.paddingMedium),
        _buildLikes(),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star,
          size: AppConstants.iconSizeMedium,
          color: AppColors.ratingGold,
        ),
        const SizedBox(width: 4),
        Text(
          movie.voteAverage.toStringAsFixed(1),
          style: AppTextStyles.ratingValue,
        ),
      ],
    );
  }

  Widget _buildLikes() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppConstants.likeIconSize,
          height: AppConstants.likeIconSize,
          decoration: const BoxDecoration(
            color: AppColors.specialColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite,
            size: AppConstants.iconSizeSmall,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Text(_formatLikes(movie.voteCount), style: AppTextStyles.likeValue),
      ],
    );
  }

  Widget _buildOverview() {
    return Text(
      movie.overview,
      style: AppTextStyles.bodySmall.copyWith(
        fontSize: AppConstants.fontSizeSmall,
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  String _formatLikes(int likes) {
    final str = likes.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
