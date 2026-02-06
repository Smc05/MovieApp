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
  static const double _appBarTitleSize = 26.0;
  static const double _appBarHeight = 64.0;
  static const int _searchBarItemOffset = 1;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    query.isEmpty ? provider.clearSearch() : provider.searchMovies(query);
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
      appBar: _buildAppBar(),
      body: Consumer<MovieProvider>(
        builder: (_, provider, searchBar) {
          return _buildBody(provider, searchBar!);
        },
        child: _SearchBarSection(
          controller: _searchController,
          onChanged: _onSearchChanged,
          onClear: _clearSearch,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: _appBarHeight,
      title: const Text(
        'Movies',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: _appBarTitleSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody(MovieProvider provider, Widget searchBar) {
    if (provider.isLoadingPopular && provider.displayMovies.isEmpty) {
      return _buildStateWithSearch(
        searchBar,
        const Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.popularError != null && provider.displayMovies.isEmpty) {
      return _buildStateWithSearch(
        searchBar,
        EmptyStateWidget(
          icon: Icons.error_outline,
          message: 'Failed to load movies\n${provider.popularError}',
        ),
      );
    }

    if (provider.displayMovies.isEmpty) {
      return _buildStateWithSearch(
        searchBar,
        const EmptyStateWidget(
          icon: Icons.search_off,
          message: 'No movies found',
        ),
      );
    }

    return _buildMovieList(provider.displayMovies, searchBar);
  }

  Widget _buildStateWithSearch(Widget searchBar, Widget content) {
    return Column(
      children: [
        searchBar,
        Expanded(child: content),
      ],
    );
  }

  Widget _buildMovieList(List<Movie> movies, Widget searchBar) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: movies.length + _searchBarItemOffset,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
            child: searchBar,
          );
        }

        return _buildMovieItem(movies[index - _searchBarItemOffset]);
      },
    );
  }

  Widget _buildMovieItem(Movie movie) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: MovieCard(
        movie: movie,
        onTap: () => _navigateToMovieDetail(movie),
      ),
    );
  }
}

/// Extracted search bar section to prevent unnecessary rebuilds
class _SearchBarSection extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchBarSection({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBarWidget(
      controller: controller,
      onChanged: onChanged,
      onClear: onClear,
    );
  }
}
