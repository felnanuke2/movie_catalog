import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/external/tmdb/model/movie_model.dart';

class TmdbTopRatedMoviesDatasource implements MediaDataSource {
  final Client _client;
  int page = 0;
  TmdbTopRatedMoviesDatasource(this._client);

  @override
  Future<List<MediaEntity>> call() async {
    final request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$TMDB_API_KEY&language=pt-br&page=${++page}'));
    if (request.statusCode != 200)
      throw MediaRequestError(message: request.body);
    var json = jsonDecode(request.body);
    final topRatedMovies = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromMap(e))
        .toList();
    return topRatedMovies;
  }
}
