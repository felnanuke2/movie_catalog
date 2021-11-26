import 'dart:convert';
import 'package:movie_catalog/media/external/tmdb/data_source/movies/created_by_model.dart';
import 'package:movie_catalog/media/external/tmdb/model/spoke_languages.dart';
import '../../../domain/entities/detail.dart';
import 'episode_model.dart';
import 'genre.dart';
import 'product_companies.dart';
import 'production_counties_model.dart';
import 'season_model.dart';

class TmdbTvDetails extends DetailsEntity {
  String? backdropPath;
  final List<TmdbCreatedBy> createdBy;
  final List<int> episodeRunTime;
  final DateTime firstAirDate;
  final List<TmdbGenreModel> genres;
  final String homepage;
  final String id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  final TmdbEpisodeModel lastEpisodeToAir;
  final String name;
  final List<ProductionCopanies> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final num popularity;
  final String posterPath;
  final List<ProductionCopanies> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final List<TmdbSeasonModel> seasons;
  final List<TmdbSpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final num voteAverage;
  final int voteCount;

  TmdbTvDetails({
    this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
            genres: genres,
            id: id,
            posterPath: posterPath,
            voteAverage: voteAverage);

  factory TmdbTvDetails.fromMap(Map<String, dynamic> map) {
    return TmdbTvDetails(
      backdropPath: map['backdrop_path'] != null ? map['backdrop_path'] : null,
      createdBy: List<TmdbCreatedBy>.from(
          map['created_by']?.map((x) => TmdbCreatedBy.fromMap(x))),
      episodeRunTime: List<int>.from(map['episode_run_time']),
      firstAirDate: DateTime.fromMillisecondsSinceEpoch(map['first_air_date']),
      genres: List<TmdbGenreModel>.from(
          map['genres']?.map((x) => TmdbGenreModel.fromMap(x))),
      homepage: map['homepage'],
      id: map['id'],
      inProduction: map['in_production'],
      languages: List<String>.from(map['languages']),
      lastAirDate: DateTime.fromMillisecondsSinceEpoch(map['last_air_date']),
      lastEpisodeToAir: TmdbEpisodeModel.fromMap(map['last_episode_toAir']),
      name: map['name'],
      networks: List<ProductionCopanies>.from(
          map['networks']?.map((x) => ProductionCopanies.fromMap(x))),
      numberOfEpisodes: map['number_of_episodes'],
      numberOfSeasons: map['number_of_seasons'],
      originCountry: List<String>.from(map['origin_country']),
      originalLanguage: map['original_language'],
      originalName: map['original_name'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      productionCompanies: List<ProductionCopanies>.from(
          map['production_companies']
              ?.map((x) => ProductionCopanies.fromMap(x))),
      productionCountries: List<ProductionCountry>.from(
          map['production_countries']
              ?.map((x) => ProductionCountry.fromMap(x))),
      seasons: List<TmdbSeasonModel>.from(
          map['seasons']?.map((x) => TmdbSeasonModel.fromMap(x))),
      spokenLanguages: List<TmdbSpokenLanguageModel>.from(
          map['spoken_languages']
              ?.map((x) => TmdbSpokenLanguageModel.fromMap(x))),
      status: map['status'],
      tagline: map['tagline'],
      type: map['type'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  factory TmdbTvDetails.fromJson(String source) =>
      TmdbTvDetails.fromMap(json.decode(source));
}
