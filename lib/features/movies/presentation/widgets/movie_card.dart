import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/dummy/dummy_movies.dart';
import 'movie_poster.dart';

class MovieCard extends StatelessWidget {
  final DummyMovie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 160,
      margin: const EdgeInsets.only(top: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card with content
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              child: Card(
                elevation: isDarkMode ? 0 : 2,
                color: isDarkMode ? const Color(0xFF1E1E1E) : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusMedium,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 140,
                    right: AppConstants.paddingMedium,
                    top: AppConstants.paddingMedium,
                    bottom: AppConstants.paddingMedium,
                  ),
                  child: _buildMovieDetails(),
                ),
              ),
            ),
          ),
          // Poster Image positioned to overflow with Hero animation
          Positioned(
            left: AppConstants.paddingMedium,
            top: -30,
            child: GestureDetector(
              onTap: onTap,
              child: Hero(
                tag: 'movie_${movie.id}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusMedium,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildPoster(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoster() {
    return MoviePoster(
      posterUrl: movie.posterPath,
      width: 100,
      height: 150,
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
        const SizedBox(height: 8),
        _buildOverview(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      movie.title,
      style: AppTextStyles.movieTitle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRatingAndLikes() {
    return Row(
      children: [_buildRating(), const SizedBox(width: 16), _buildLikes()],
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, size: 14, color: AppColors.ratingGold),
        const SizedBox(width: 4),
        Text(
          movie.voteAverage.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.ratingGold,
          ),
        ),
      ],
    );
  }

  Widget _buildLikes() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: AppColors.special,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.favorite, size: 12, color: Colors.white),
        ),
        const SizedBox(width: 4),
        Text(
          _formatLikes(movie.voteCount),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.special,
          ),
        ),
      ],
    );
  }

  Widget _buildOverview() {
    return Text(
      movie.overview,
      style: AppTextStyles.bodySmall.copyWith(fontSize: 12, height: 1.4),
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
