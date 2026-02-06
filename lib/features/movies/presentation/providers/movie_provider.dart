import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  final MovieRepository repository;

  MovieProvider({required this.repository});

  // State for popular movies
  List<Movie> _popularMovies = [];
  bool _isLoadingPopular = false;
  String? _popularError;

  // State for search
  List<Movie> _searchResults = [];
  bool _isSearching = false;
  String? _searchError;
  String _searchQuery = '';

  // State for movie details
  MovieDetail? _selectedMovieDetail;
  bool _isLoadingDetail = false;
  String? _detailError;

  // Getters
  List<Movie> get popularMovies => _popularMovies;
  bool get isLoadingPopular => _isLoadingPopular;
  String? get popularError => _popularError;

  List<Movie> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  String? get searchError => _searchError;
  String get searchQuery => _searchQuery;

  MovieDetail? get selectedMovieDetail => _selectedMovieDetail;
  bool get isLoadingDetail => _isLoadingDetail;
  String? get detailError => _detailError;

  // Get display movies (search results if searching, popular otherwise)
  List<Movie> get displayMovies =>
      _searchQuery.isEmpty ? _popularMovies : _searchResults;

  // Fetch popular movies
  Future<void> fetchPopularMovies({String language = 'en-US'}) async {
    _isLoadingPopular = true;
    _popularError = null;
    notifyListeners();

    try {
      _popularMovies = await repository.getPopularMovies(language: language);
      _popularError = null;
    } catch (e) {
      _popularError = e.toString();
    } finally {
      _isLoadingPopular = false;
      notifyListeners();
    }
  }

  // Search movies
  Future<void> searchMovies(String query, {String language = 'en-US'}) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _searchResults = [];
      _searchError = null;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _searchError = null;
    notifyListeners();

    try {
      _searchResults = await repository.searchMovies(query, language: language);
      _searchError = null;
    } catch (e) {
      _searchError = e.toString();
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _searchError = null;
    notifyListeners();
  }

  // Fetch movie details
  Future<void> fetchMovieDetails(
    int movieId, {
    String language = 'en-US',
  }) async {
    _isLoadingDetail = true;
    _detailError = null;
    _selectedMovieDetail = null;
    notifyListeners();

    try {
      _selectedMovieDetail = await repository.getMovieDetails(
        movieId,
        language: language,
      );
      _detailError = null;
    } catch (e) {
      _detailError = e.toString();
    } finally {
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  // Clear movie details
  void clearMovieDetails() {
    _selectedMovieDetail = null;
    _detailError = null;
    notifyListeners();
  }
}
