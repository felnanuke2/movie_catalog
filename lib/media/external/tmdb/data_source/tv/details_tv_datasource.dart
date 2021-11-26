import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/external/tmdb/model/tv_details_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbDetailsTvDataSource<T extends DetailsEntity>
    implements DetailsDataSource<T> {
  final Client _client;
  final String language;
  final String id;
  TmdbDetailsTvDataSource(this._client,
      {required this.id, required this.language});

  @override
  Future<T> call() async {
    final request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?api_key=$TMDB_API_KEY&language=$language'));
    TmdbUtils.throwError(request);
    final json = jsonDecode(request.body);
    final movieModelDetail = TmdbTvDetails.fromMap(json);
    return movieModelDetail as T;
  }
}
