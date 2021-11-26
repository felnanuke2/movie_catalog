import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/external/tmdb/model/video_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbVideosTvDatasource<T extends VideoEntity>
    implements VideoDataSource<T> {
  final String id;
  final String language;
  final Client _client;
  TmdbVideosTvDatasource(
    this._client, {
    required this.language,
    required this.id,
  });
  @override
  Future<List<T>> call() async {
    var request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/videos?api_key=$TMDB_API_KEY&language=$language'));
    TmdbUtils.throwError(request);
    var json = jsonDecode(request.body);
    final listVideoModel = List.from(json['results'])
        .map((e) => TmdbVideoModel.fromMap(e))
        .toList();
    listVideoModel.removeWhere((element) => element.site != 'YouTube');
    return listVideoModel as List<T>;
  }
}
