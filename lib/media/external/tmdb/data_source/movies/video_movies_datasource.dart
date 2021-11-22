import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/external/tmdb/model/movie_video_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbVideoDatasource implements VideoDataSource {
  final Client _client;
  final String id;
  TmdbVideoDatasource(this._client, {required this.id});

  @override
  Future<List<VideoEntity>> call() async {
    var request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$TMDB_API_KEY&language=pt-BR'));
    TmdbUtils.throwError(request);
    var json = jsonDecode(request.body);
    final listVideoModel = List.from(json['results'])
        .map((e) => TmdbVideoModel.fromMap(e))
        .toList();
    listVideoModel.removeWhere((element) => element.site != 'YouTube');
    return listVideoModel;
  }
}
