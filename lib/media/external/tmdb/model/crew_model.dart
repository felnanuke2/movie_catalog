import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/person.dart';

class TmdbCrewModel extends PersonEntity {
  bool? adult;
  int? gender;
  String id;
  String? knownForDepartment;
  String name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  TmdbCrewModel({
    required this.id,
    required this.name,
    this.adult,
    this.gender,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.department,
    this.job,
  }) : super(id: id, name: name, profilePath: profilePath);

  factory TmdbCrewModel.fromMap(Map<String, dynamic> map) {
    return TmdbCrewModel(
      adult: map['adult'] != null ? map['adult'] : null,
      gender: map['gender'] != null ? map['gender'] : null,
      id: map['id'].toString(),
      knownForDepartment:
          map['knownForDepartment'] != null ? map['knownForDepartment'] : null,
      name: map['name'],
      originalName: map['originalName'] != null ? map['originalName'] : null,
      popularity: map['popularity'] != null ? map['popularity'] : null,
      profilePath: map['profilePath'] != null ? map['profilePath'] : null,
      creditId: map['creditId'] != null ? map['creditId'] : null,
      department: map['department'] != null ? map['department'] : null,
      job: map['job'] != null ? map['job'] : null,
    );
  }

  factory TmdbCrewModel.fromJson(String source) =>
      TmdbCrewModel.fromMap(json.decode(source));
}
