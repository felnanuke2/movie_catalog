import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/external/tmdb/model/media_model.dart';

class TmdbPopularTvDatasource<T extends MediaEntity>
    implements MediaDataSource<T> {
  final Client _client;
  final String language;
  int page = 0;
  TmdbPopularTvDatasource(this._client, {required this.language});

  @override
  Future<List<T>> call() async {
    final request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/popular?api_key=$TMDB_API_KEY&language=$language&page=${++page}'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    var moviesList = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromMap(e))
        .toList();
    return moviesList as List<T>;
  }
}
