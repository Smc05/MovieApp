import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
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
    // Fetch movie details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          // Show loading indicator
          if (provider.isLoadingDetail) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message
          if (provider.detailError != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load movie details',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.detailError!,
                      style: const TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Show movie details
          final movie = provider.selectedMovieDetail;
          if (movie == null) {
            return const Center(child: Text('Movie not found'));
          }

          return _buildMovieDetails(movie);
        },
      ),
    );
  }

  Widget _buildMovieDetails(MovieDetail movie) {
    final screenHeight = MediaQuery.of(context).size.height;
    final posterHeight = screenHeight * 0.6;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPosterSection(context, posterHeight, movie),
          _buildDetailsSection(movie),
        ],
      ),
    );
  }

  Widget _buildPosterSection(
    BuildContext context,
    double posterHeight,
    MovieDetail movie,
  ) {
    final fullPosterUrl = movie.posterPath.isNotEmpty
        ? '${AppConstants.imageBaseUrl}/w500${movie.posterPath}'
        : '';

    return SizedBox(
      height: posterHeight,
      child: Stack(
        children: [
          // Movie Poster Background
          Hero(
            tag: 'movie_${movie.id}',
            child: MoviePoster(
              posterUrl: fullPosterUrl,
              width: double.infinity,
              height: posterHeight,
              borderRadius: BorderRadius.zero,
            ),
          ),
          // Gradient Overlay
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
          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Movie Title and Rating at Bottom
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.ratingGold,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.ratingGold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 40, color: AppColors.divider);
  }

  Widget _buildGenreTags(MovieDetail movie) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: movie.genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.special,
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: Text(
            genre,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSynopsis(MovieDetail movie) {
    return Text(
      movie.overview,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
    );
  }

  String _formatPopularity(int voteCount) {
    if (voteCount >= 1000) {
      return '${(voteCount / 1000).toStringAsFixed(1)}K';
    }
    return voteCount.toString();
  }
}
