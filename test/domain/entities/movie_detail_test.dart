import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movies/domain/entities/movie_detail.dart';

void main() {
  group('MovieDetail Entity Tests', () {
    test('5. MovieDetail formattedRuntime returns correct format', () {
      // Arrange
      final movieDetail = MovieDetail(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        releaseDate: '2024-01-01',
        voteAverage: 8.5,
        voteCount: 1000,
        genres: ['Action', 'Adventure'],
        runtime: 142, // 2 hours 22 minutes
        status: 'Released',
        budget: 150000000,
        revenue: 500000000,
        tagline: 'Test tagline',
        originalLanguage: 'en',
        cast: [],
      );

      // Act
      final formattedRuntime = movieDetail.formattedRuntime;

      // Assert
      expect(formattedRuntime, '2h 22m');
    });

    test('6. MovieDetail handles zero runtime', () {
      // Arrange
      final movieDetail = MovieDetail(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        releaseDate: '2024-01-01',
        voteAverage: 8.5,
        voteCount: 1000,
        genres: ['Action'],
        runtime: 0,
        status: 'Released',
        budget: 150000000,
        revenue: 500000000,
        tagline: 'Test tagline',
        originalLanguage: 'en',
        cast: [],
      );

      // Act
      final formattedRuntime = movieDetail.formattedRuntime;

      // Assert
      expect(formattedRuntime, 'N/A');
    });

    test('7. MovieDetail releaseYear extracts year correctly', () {
      // Arrange
      final movieDetail = MovieDetail(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        releaseDate: '2025-06-15',
        voteAverage: 8.5,
        voteCount: 1000,
        genres: ['Action'],
        runtime: 120,
        status: 'Released',
        budget: 150000000,
        revenue: 500000000,
        tagline: 'Test tagline',
        originalLanguage: 'en',
        cast: [],
      );

      // Act
      final year = movieDetail.releaseYear;

      // Assert
      expect(year, '2025');
    });
  });
}
