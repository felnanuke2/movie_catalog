import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/genre.dart';

class TmdbGenreModel extends GenreEntity {
  final String id;
  final String name;
  TmdbGenreModel(
    this.id,
    this.name,
  ) : super(id: id, name: name);

  factory TmdbGenreModel.fromMap(Map<String, dynamic> map) {
    return TmdbGenreModel(
      map['id'],
      map['name'],
    );
  }

  factory TmdbGenreModel.fromJson(String source) =>
      TmdbGenreModel.fromMap(json.decode(source));
}
