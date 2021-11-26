import 'dart:convert';

class TmdbEpisodeModel {
  final DateTime airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final num voteAverage;
  final int voteCount;
  TmdbEpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TmdbEpisodeModel.fromMap(Map<String, dynamic> map) {
    return TmdbEpisodeModel(
      airDate: DateTime.fromMillisecondsSinceEpoch(map['air_date']),
      episodeNumber: map['episode_number'],
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      productionCode: map['production_code'],
      seasonNumber: map['season_number'],
      stillPath: map['stillPath'] != null ? map['still_path'] : null,
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  factory TmdbEpisodeModel.fromJson(String source) =>
      TmdbEpisodeModel.fromMap(json.decode(source));
}
