import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/external/tmdb/model/movie_detail_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class DetailsMovieDatasource implements DetailsDataSource {
  final Client _client;
  final String id;
  DetailsMovieDatasource(this._client, this.id);

  @override
  Future<DetailsEntity> call() async {
    var request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$TMDB_API_KEY&language=pt-BR'));
    // the code below throw errors if status code is diferent 200
    TmdbUtils.throwError(request);
    var json = jsonDecode(request.body);
    final movieModelDetail = TmdbMovieDetail.fromMap(json);
    return movieModelDetail;
  }
}
