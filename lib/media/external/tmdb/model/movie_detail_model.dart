import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/external/tmdb/model/genre.dart';

class TmdbMovieDetail extends DetailsEntity {
  final bool adult;
  final String? backdropPath;
  final num budget;
  final List<TmdbGenreModel> genres;
  final String? homepage;
  final String id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final int revenue;
  final int? runtime;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  TmdbMovieDetail({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
            id: id,
            genres: genres,
            posterPath: posterPath,
            voteAverage: voteAverage);

  factory TmdbMovieDetail.fromMap(Map<String, dynamic> map) {
    return TmdbMovieDetail(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      budget: map['budget'],
      genres: List<TmdbGenreModel>.from(
          map['genres']?.map((x) => TmdbGenreModel.fromMap(x))),
      homepage: map['homepage'],
      id: map['id'],
      imdbId: map['imdb_id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'] ?? '',
      releaseDate: DateTime.parse(map['release_date']),
      revenue: map['revenue'],
      runtime: map['runtime'],
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  factory TmdbMovieDetail.fromJson(String source) =>
      TmdbMovieDetail.fromMap(json.decode(source));
}
