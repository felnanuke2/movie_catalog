import 'dart:convert';

import 'package:movie_catalog/media/domain/entities/video.dart';

class TmdbVideoModel extends VideoEntity {
  final String id;
  String? iso6391;
  String? iso31661;
  final String key;
  String? name;
  String? site;
  int? size;
  String? type;
  TmdbVideoModel({
    required this.id,
    this.iso6391,
    this.iso31661,
    required this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  }) : super(
            id: id,
            src: key,
            thumbnail: 'https://img.youtube.com/vi/$key/0.jpg');

  factory TmdbVideoModel.fromMap(Map<String, dynamic> map) {
    return TmdbVideoModel(
      id: map['id'],
      iso6391: map['iso6391'] != null ? map['iso6391'] : null,
      iso31661: map['iso31661'] != null ? map['iso31661'] : null,
      key: map['key'],
      name: map['name'] != null ? map['name'] : null,
      site: map['site'] != null ? map['site'] : null,
      size: map['size'] != null ? map['size'] : null,
      type: map['type'] != null ? map['type'] : null,
    );
  }

  factory TmdbVideoModel.fromJson(String source) =>
      TmdbVideoModel.fromMap(json.decode(source));
}
