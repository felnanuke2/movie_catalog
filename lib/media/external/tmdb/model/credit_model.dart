import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/external/tmdb/model/cast_mode.dart';
import 'package:movie_catalog/media/external/tmdb/model/crew_model.dart';

class TmdbCreditModel extends CreditEntity {
  final String id;
  final List<TmdbCastModel> cast;
  final List<TmdbCrewModel> crew;
  TmdbCreditModel({
    required this.id,
    required this.cast,
    required this.crew,
  }) : super(id: id, cast: cast, crew: crew);

  factory TmdbCreditModel.fromMap(Map<String, dynamic> map) {
    return TmdbCreditModel(
      id: map['id'].toString(),
      cast: List<TmdbCastModel>.from(
          map['cast']?.map((x) => TmdbCastModel.fromMap(x))),
      crew: List<TmdbCrewModel>.from(
          map['crew']?.map((x) => TmdbCrewModel.fromMap(x))),
    );
  }

  factory TmdbCreditModel.fromJson(String source) =>
      TmdbCreditModel.fromMap(json.decode(source));
}
