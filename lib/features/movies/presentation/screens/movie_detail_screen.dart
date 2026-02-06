import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/entities/movie_detail.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_poster.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingDetail) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.detailError != null) {
            return _buildErrorState(provider.detailError!);
          }

          final movie = provider.selectedMovieDetail;
          if (movie == null) {
            return const Center(child: Text('Movie not found'));
          }

          return _buildMovieDetails(movie);
        },
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppConstants.iconSizeXXLarge,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            const Text(
              'Failed to load movie details',
              style: AppTextStyles.errorTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              error,
              style: AppTextStyles.errorMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingLarge),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieDetails(MovieDetail movie) {
    final screenHeight = MediaQuery.of(context).size.height;
    final posterHeight = screenHeight * AppConstants.detailPosterHeightRatio;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPosterSection(posterHeight, movie),
          _buildDetailsSection(movie),
        ],
      ),
    );
  }

  Widget _buildPosterSection(double posterHeight, MovieDetail movie) {
    final fullPosterUrl = movie.posterPath.isNotEmpty
        ? '${AppConstants.imageBaseUrl}/w500${movie.posterPath}'
        : '';

    return SizedBox(
      height: posterHeight,
      child: Stack(
        children: [
          _buildPosterWithGradient(fullPosterUrl, posterHeight),
          _buildBackButton(),
          _buildTitleAndRating(movie),
        ],
      ),
    );
  }

  Widget _buildPosterWithGradient(String posterUrl, double posterHeight) {
    return Stack(
      children: [
        Hero(
          tag: 'movie_${widget.movieId}',
          child: MoviePoster(
            posterUrl: posterUrl,
            width: double.infinity,
            height: posterHeight,
            borderRadius: BorderRadius.zero,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top:
          MediaQuery.of(context).padding.top + AppConstants.detailBackButtonTop,
      left: AppConstants.detailBackButtonLeft,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: AppConstants.detailBackButtonSize,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildTitleAndRating(MovieDetail movie) {
    return Positioned(
      left: AppConstants.detailTitleHorizontal,
      right: AppConstants.detailTitleHorizontal,
      bottom: AppConstants.detailTitleBottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.title, style: AppTextStyles.detailTitle),
          const SizedBox(height: AppConstants.paddingSmall),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColors.ratingGold,
                size: AppConstants.iconSizeLarge,
              ),
              const SizedBox(width: AppConstants.paddingSmall),
              Text(
                movie.voteAverage.toStringAsFixed(1),
                style: AppTextStyles.detailRating,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(MovieDetail movie) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(movie),
          const SizedBox(height: AppConstants.paddingLarge),
          _buildGenreTags(movie),
          const SizedBox(height: AppConstants.paddingLarge),
          _buildSynopsis(movie),
        ],
      ),
    );
  }

  Widget _buildInfoRow(MovieDetail movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoColumn('Status', movie.status),
        _buildDivider(),
        _buildInfoColumn('Popularity', _formatPopularity(movie.voteCount)),
        _buildDivider(),
        _buildInfoColumn('Language', movie.originalLanguage.toUpperCase()),
      ],
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: AppTextStyles.infoLabel),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            value,
            style: AppTextStyles.infoValue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: AppConstants.dividerWidth,
      height: AppConstants.dividerHeight,
      color: AppColors.divider,
    );
  }

  Widget _buildGenreTags(MovieDetail movie) {
    return Wrap(
      spacing: AppConstants.genreTagSpacing,
      runSpacing: AppConstants.genreTagSpacing,
      children: movie.genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.genreTagPaddingHorizontal,
            vertical: AppConstants.genreTagPaddingVertical,
          ),
          decoration: BoxDecoration(
            color: AppColors.specialColor,
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: Text(genre, style: AppTextStyles.genreTag),
        );
      }).toList(),
    );
  }

  Widget _buildSynopsis(MovieDetail movie) {
    return Text(movie.overview, style: AppTextStyles.synopsis);
  }

  String _formatPopularity(int voteCount) {
    if (voteCount >= AppConstants.popularityThousandThreshold) {
      return '${(voteCount / AppConstants.popularityThousandThreshold).toStringAsFixed(1)}K';
    }
    return voteCount.toString();
  }
}
