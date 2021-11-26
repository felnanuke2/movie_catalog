import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';

import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/external/tmdb/model/media_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbOnAirTvDatasource<T extends MediaEntity>
    implements MediaDataSource<T> {
  final Client _client;
  int page = 0;
  final String language;
  TmdbOnAirTvDatasource(
    this._client, {
    required this.language,
  });

  @override
  Future<List<T>> call() async {
    var request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/on_ait?api_key=$TMDB_API_KEY&language=$language&page=${++page}'));
    TmdbUtils.throwError(request);
    var json = jsonDecode(request.body);
    final playnowMovies = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromMap(e))
        .toList();
    return playnowMovies as List<T>;
  }
}
