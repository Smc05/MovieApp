import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/dummy/dummy_movies.dart';
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
  List<DummyMovie> _filteredMovies = [];
  final List<DummyMovie> _allMovies = DummyMovieData.getMovies();

  @override
  void initState() {
    super.initState();
    _filteredMovies = _allMovies;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMovies(String query) {
    setState(() {
      _filteredMovies = query.isEmpty
          ? _allMovies
          : _allMovies
                .where(
                  (movie) =>
                      movie.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterMovies('');
  }

  void _navigateToMovieDetail(DummyMovie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movie)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies", style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: _filterMovies,
            onClear: _clearSearch,
          ),
          Expanded(
            child: _filteredMovies.isEmpty
                ? const EmptyStateWidget(
                    icon: Icons.search_off,
                    message: 'No movies found',
                  )
                : _buildMovieList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: _filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = _filteredMovies[index];
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
