import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/external/tmdb/model/media_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbMovieSearchDatasource<T extends MediaEntity>
    implements MediaDataSource<T> {
  final Client _client;
  int page = 0;
  final String query;
  final String laguage;

  TmdbMovieSearchDatasource(
    this._client, {
    required this.query,
    required this.laguage,
  });

  @override
  Future<List<T>> call() async {
    final request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$TMDB_API_KEY&language=$laguage&query=$query&page=${++page}'));
    TmdbUtils.throwError(request);
    final json = jsonDecode(request.body);
    final search = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromMap(e))
        .toList();

    return search as List<T>;
  }
}
