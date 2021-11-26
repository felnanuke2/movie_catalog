import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/external/tmdb/model/media_model.dart';

class TmdbTvTopRated<T extends MediaEntity> implements MediaDataSource<T> {
  final Client _client;
  final String language;
  int page = 0;
  TmdbTvTopRated(this._client, {required this.language});

  @override
  Future<List<T>> call() async {
    final request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=$TMDB_API_KEY&language=$language&page=$page'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final topRatedMovies = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromJson(e))
        .toList();
    return topRatedMovies as List<T>;
  }
}
