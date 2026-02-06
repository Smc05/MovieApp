import 'cast.dart';

class MovieDetail {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;
  final int runtime;
  final String status;
  final int budget;
  final int revenue;
  final String tagline;
  final String originalLanguage;
  final List<Cast> cast;

  MovieDetail({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.runtime,
    required this.status,
    required this.budget,
    required this.revenue,
    required this.tagline,
    required this.originalLanguage,
    required this.cast,
  });

  String get releaseYear =>
      releaseDate.isNotEmpty ? releaseDate.split('-')[0] : 'N/A';

  String get formattedRuntime {
    if (runtime == 0) return 'N/A';
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return '${hours}h ${minutes}m';
  }
}
