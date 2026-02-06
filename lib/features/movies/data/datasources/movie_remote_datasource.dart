import '../../../../core/network/api_client.dart';
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';
import '../models/cast_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  });
  Future<List<MovieModel>> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  });
  Future<List<MovieModel>> searchMovies(
    String query, {
    int page = 1,
    String language = 'en-US',
  });
  Future<MovieDetailModel> getMovieDetails(
    int movieId, {
    String language = 'en-US',
  });
  Future<List<CastModel>> getMovieCredits(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;

  MovieRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  }) async {
    try {
      final response = await apiClient.get(
        '/movie/popular',
        queryParameters: {'page': page.toString()},
        language: language,
      );

      final List results = response['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch popular movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  }) async {
    try {
      final response = await apiClient.get(
        '/movie/top_rated',
        queryParameters: {'page': page.toString()},
        language: language,
      );

      final List results = response['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch top rated movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(
    String query, {
    int page = 1,
    String language = 'en-US',
  }) async {
    try {
      final response = await apiClient.get(
        '/search/movie',
        queryParameters: {'query': query, 'page': page.toString()},
        language: language,
      );

      final List results = response['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(
    int movieId, {
    String language = 'en-US',
  }) async {
    try {
      final response = await apiClient.get(
        '/movie/$movieId',
        language: language,
      );

      return MovieDetailModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }

  @override
  Future<List<CastModel>> getMovieCredits(int movieId) async {
    try {
      final response = await apiClient.get('/movie/$movieId/credits');

      final List cast = response['cast'];
      return cast.take(10).map((json) => CastModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch movie credits: $e');
    }
  }
}
