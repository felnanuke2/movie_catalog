import 'dart:convert';

class TmdbSeasonModel {
  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  TmdbSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory TmdbSeasonModel.fromMap(Map<String, dynamic> map) {
    return TmdbSeasonModel(
      airDate: DateTime.fromMillisecondsSinceEpoch(map['air_date']),
      episodeCount: map['episode_count'],
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      seasonNumber: map['season_number'],
    );
  }

  factory TmdbSeasonModel.fromJson(String source) =>
      TmdbSeasonModel.fromMap(json.decode(source));
}
