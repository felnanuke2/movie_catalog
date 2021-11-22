import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/external/tmdb/model/movie_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbPopularMoviesDatasource implements MediaDataSource {
  final Client _client;
  int page = 0;
  TmdbPopularMoviesDatasource(this._client);

  @override
  Future<List<MediaEntity>> call() async {
    final request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$TMDB_API_KEY&language=pt-br&page=${++page}'));
    TmdbUtils.throwError(request);
    var json = jsonDecode(request.body);
    var moviesList = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromMap(e))
        .toList();
    return moviesList;
  }
}
