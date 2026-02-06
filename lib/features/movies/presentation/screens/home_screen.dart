import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie.dart';
import '../providers/movie_provider.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar_widget.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch popular movies when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().fetchPopularMovies();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final provider = context.read<MovieProvider>();
    if (query.isEmpty) {
      provider.clearSearch();
    } else {
      provider.searchMovies(query);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<MovieProvider>().clearSearch();
  }

  void _navigateToMovieDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MovieDetailScreen(movieId: movie.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: _onSearchChanged,
            onClear: _clearSearch,
          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, provider, child) {
                // Show loading indicator
                if (provider.isLoadingPopular &&
                    provider.displayMovies.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Show error message
                if (provider.popularError != null &&
                    provider.displayMovies.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.error_outline,
                    message: 'Failed to load movies\n${provider.popularError}',
                  );
                }

                // Show empty state
                if (provider.displayMovies.isEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.search_off,
                    message: 'No movies found',
                  );
                }

                // Show movie list
                return _buildMovieList(provider.displayMovies);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
          child: MovieCard(
            movie: movie,
            onTap: () => _navigateToMovieDetail(movie),
          ),
        );
      },
    );
  }
}
