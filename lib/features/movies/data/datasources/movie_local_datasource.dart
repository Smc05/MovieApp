import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cachePopularMovies(List<MovieModel> movies);
  Future<List<MovieModel>?> getCachedPopularMovies();
  Future<void> cacheMovieDetail(MovieDetailModel movie);
  Future<MovieDetailModel?> getCachedMovieDetail(int movieId);
  Future<void> clearCache();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  static const String _popularMoviesKey = 'cached_popular_movies';
  static const String _movieDetailPrefix = 'cached_movie_detail_';

  @override
  Future<void> cachePopularMovies(List<MovieModel> movies) async {
    final jsonList = movies.map((movie) => movie.toJson()).toList();
    await sharedPreferences.setString(_popularMoviesKey, json.encode(jsonList));
  }

  @override
  Future<List<MovieModel>?> getCachedPopularMovies() async {
    final jsonString = sharedPreferences.getString(_popularMoviesKey);
    if (jsonString != null) {
      final List decoded = json.decode(jsonString);
      return decoded.map((json) => MovieModel.fromJson(json)).toList();
    }
    return null;
  }

  @override
  Future<void> cacheMovieDetail(MovieDetailModel movie) async {
    await sharedPreferences.setString(
      '$_movieDetailPrefix${movie.id}',
      json.encode(movie.toJson()),
    );
  }

  @override
  Future<MovieDetailModel?> getCachedMovieDetail(int movieId) async {
    final jsonString = sharedPreferences.getString(
      '$_movieDetailPrefix$movieId',
    );
    if (jsonString != null) {
      return MovieDetailModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.clear();
  }
}
