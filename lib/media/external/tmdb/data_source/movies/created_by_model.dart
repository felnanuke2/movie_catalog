import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/person.dart';

class TmdbCreatedBy extends PersonEntity {
  final String id;
  final String creditId;
  final String name;
  final int gender;
  String? profilePath;

  TmdbCreatedBy(
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  ) : super(
          id: id,
          name: name,
          profilePath: profilePath,
        );

  factory TmdbCreatedBy.fromMap(Map<String, dynamic> map) {
    return TmdbCreatedBy(
      map['id'],
      map['credit_id'],
      map['name'],
      map['gender'],
      map['profile_path'] != null ? map['profile_path'] : null,
    );
  }

  factory TmdbCreatedBy.fromJson(String source) =>
      TmdbCreatedBy.fromMap(json.decode(source));
}
