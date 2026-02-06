import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

void main() {
  group('Movie Entity Tests', () {
    test('1. Movie entity creates correctly with all fields', () {
      // Arrange
      final movie = Movie(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        releaseDate: '2024-01-01',
        voteAverage: 8.5,
        voteCount: 1000,
        genreIds: [28, 12],
        originalLanguage: 'en',
      );

      // Assert
      expect(movie.id, 1);
      expect(movie.title, 'Test Movie');
      expect(movie.voteAverage, 8.5);
      expect(movie.voteCount, 1000);
      expect(movie.genreIds, [28, 12]);
    });

    test('2. Movie fullPosterPath returns correct URL', () {
      // Arrange
      final movie = Movie(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        releaseDate: '2024-01-01',
        voteAverage: 8.5,
        voteCount: 1000,
        genreIds: [28, 12],
        originalLanguage: 'en',
      );

      // Act
      final posterUrl = movie.fullPosterPath;

      // Assert
      expect(posterUrl, 'https://image.tmdb.org/t/p/w500/poster.jpg');
    });

    test('3. Movie releaseYear extracts year correctly', () {
      // Arrange
      final movie = Movie(
        id: 1,
        title: 'Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        releaseDate: '2024-12-25',
        voteAverage: 8.5,
        voteCount: 1000,
        genreIds: [28, 12],
        originalLanguage: 'en',
      );

      // Act
      final year = movie.releaseYear;

      // Assert
      expect(year, '2024');
    });

    test('4. Movie handles empty posterPath gracefully', () {
      // Arrange
      final movie = Movie(
        id: 1,
        title: 'Test Movie',
        posterPath: '',
        backdropPath: '',
        overview: 'Test overview',
        releaseDate: '2024-01-01',
        voteAverage: 8.5,
        voteCount: 1000,
        genreIds: [],
        originalLanguage: 'en',
      );

      // Act
      final posterUrl = movie.fullPosterPath;

      // Assert
      expect(posterUrl, '');
    });
  });
}
