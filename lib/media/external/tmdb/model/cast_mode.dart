import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/person.dart';

class TmdbCastModel extends PersonEntity {
  bool? adult;
  int? gender;
  String id;
  String? knownForDepartment;
  String name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  TmdbCastModel(
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  ) : super(id: id, name: name, profilePath: profilePath);

  factory TmdbCastModel.fromMap(Map<String, dynamic> map) {
    return TmdbCastModel(
      map['adult'] != null ? map['adult'] : null,
      map['gender'] != null ? map['gender'] : null,
      map['id'].toString(),
      map['knownForDepartment'] != null ? map['knownForDepartment'] : null,
      map['name'],
      map['originalName'] != null ? map['originalName'] : null,
      map['popularity'] != null ? map['popularity'] : null,
      map['profilePath'] != null ? map['profilePath'] : null,
      map['castId'] != null ? map['castId'] : null,
      map['character'] != null ? map['character'] : null,
      map['creditId'] != null ? map['creditId'] : null,
      map['order'] != null ? map['order'] : null,
    );
  }

  factory TmdbCastModel.fromJson(String source) =>
      TmdbCastModel.fromMap(json.decode(source));
}
