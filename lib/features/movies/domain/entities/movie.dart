import '../../../../core/constants/api_constants.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final String originalLanguage;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.originalLanguage,
  });

  String get fullPosterPath =>
      posterPath.isNotEmpty ? '${ApiConstants.posterW500}$posterPath' : '';

  String get fullBackdropPath => backdropPath.isNotEmpty
      ? '${ApiConstants.backdropW780}$backdropPath'
      : '';

  String get releaseYear =>
      releaseDate.isNotEmpty ? releaseDate.split('-')[0] : 'N/A';
}
