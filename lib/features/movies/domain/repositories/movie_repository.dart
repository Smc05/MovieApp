import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  });
  Future<List<Movie>> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  });
  Future<List<Movie>> searchMovies(
    String query, {
    int page = 1,
    String language = 'en-US',
  });
  Future<MovieDetail> getMovieDetails(int movieId, {String language = 'en-US'});
}
