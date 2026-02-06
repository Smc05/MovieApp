import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_detail.dart';
import 'cast_model.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  final int id;
  final String title;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final String overview;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final List<GenreModel> genres;
  final int? runtime;
  final String status;
  final int budget;
  final int revenue;
  final String? tagline;
  @JsonKey(name: 'original_language')
  final String originalLanguage;

  MovieDetailModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    this.runtime,
    required this.status,
    required this.budget,
    required this.revenue,
    this.tagline,
    required this.originalLanguage,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);

  MovieDetail toEntity(List<CastModel> cast) {
    return MovieDetail(
      id: id,
      title: title,
      posterPath: posterPath ?? '',
      backdropPath: backdropPath ?? '',
      overview: overview,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      genres: genres.map((g) => g.name).toList(),
      runtime: runtime ?? 0,
      status: status,
      budget: budget,
      revenue: revenue,
      tagline: tagline ?? '',
      originalLanguage: originalLanguage,
      cast: cast.map((c) => c.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}
