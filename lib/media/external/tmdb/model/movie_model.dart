import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/media.dart';

class TmdbMediaModel extends MediaEntity {
  final String? posterPath;
  final bool adult;
  final String overview;
  final DateTime releaseDate;
  final List<int> genreIds;
  final String id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final num popularity;
  final num voteCount;
  final bool video;
  final num voteAverage;
  TmdbMediaModel({
    this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  }) : super(
            banner: posterPath ?? backdropPath ?? '',
            id: id,
            name: title,
            rate: voteAverage);

  factory TmdbMediaModel.fromMap(Map<String, dynamic> map) {
    return TmdbMediaModel(
      posterPath: map['posterPath'] != null ? map['poster_path'] : null,
      adult: map['adult'],
      overview: map['overview'],
      releaseDate: DateTime.parse(map['release_date']),
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id'].toString(),
      originalTitle: map['original_title'],
      originalLanguage: map['original_language'],
      title: map['title'],
      backdropPath: map['backdrop_path'],
      popularity: map['popularity'],
      voteCount: map['vote_count'],
      video: map['video'],
      voteAverage: map['vote_average'],
    );
  }

  factory TmdbMediaModel.fromJson(String source) =>
      TmdbMediaModel.fromMap(json.decode(source));
}
