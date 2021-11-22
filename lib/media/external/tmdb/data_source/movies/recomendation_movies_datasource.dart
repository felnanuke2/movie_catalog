import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/external/tmdb/model/movie_model.dart';

class TmdbRecomendationMoviesDatasource implements MediaDataSource {
  final Client _client;
  int page = 0;
  final String movieId;
  TmdbRecomendationMoviesDatasource(
    this._client, {
    required this.movieId,
  });

  @override
  Future<List<MediaEntity>> call() async {
    var request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$TMDB_API_KEY&language=pt-br'));
    if (request.statusCode != 200)
      throw MediaRequestError(message: request.body);
    var json = jsonDecode(request.body);
    final recomendationsList = List.from(json['results'])
        .map((e) => TmdbMediaModel.fromMap(e))
        .toList();
    return recomendationsList;
  }
}
