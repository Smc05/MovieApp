import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_datasource.dart';
import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Movie>> getPopularMovies({
    int page = 1,
    String language = 'en-US',
  }) async {
    try {
      final movieModels = await remoteDataSource.getPopularMovies(
        page: page,
        language: language,
      );

      // Cache the first page
      if (page == 1) {
        await localDataSource.cachePopularMovies(movieModels);
      }

      return movieModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Try to get cached data on failure
      final cachedMovies = await localDataSource.getCachedPopularMovies();
      if (cachedMovies != null) {
        return cachedMovies.map((model) => model.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies({
    int page = 1,
    String language = 'en-US',
  }) async {
    final movieModels = await remoteDataSource.getTopRatedMovies(
      page: page,
      language: language,
    );
    return movieModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Movie>> searchMovies(
    String query, {
    int page = 1,
    String language = 'en-US',
  }) async {
    final movieModels = await remoteDataSource.searchMovies(
      query,
      page: page,
      language: language,
    );
    return movieModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<MovieDetail> getMovieDetails(
    int movieId, {
    String language = 'en-US',
  }) async {
    try {
      // Try to fetch from API
      final movieDetailModel = await remoteDataSource.getMovieDetails(
        movieId,
        language: language,
      );
      final castModels = await remoteDataSource.getMovieCredits(movieId);

      // Cache the movie detail
      await localDataSource.cacheMovieDetail(movieDetailModel);

      return movieDetailModel.toEntity(castModels);
    } catch (e) {
      // Try to get cached data on failure
      final cachedMovie = await localDataSource.getCachedMovieDetail(movieId);
      if (cachedMovie != null) {
        return cachedMovie.toEntity([]);
      }
      rethrow;
    }
  }
}
