import 'dart:convert';

import 'package:http/http.dart';

import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/external/tmdb/model/credit_model.dart';
import 'package:movie_catalog/media/external/tmdb/utils/utils.dart';

class TmdbCreditsTvDatasource<T extends CreditEntity>
    implements CreditDataSource<T> {
  final String id;
  final Client _client;
  final String language;
  TmdbCreditsTvDatasource(
    this._client, {
    required this.id,
    required this.language,
  });

  @override
  Future<T> call() async {
    var request = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/credits?api_key=$TMDB_API_KEY&language=$language'));
    TmdbUtils.throwError(request);
    var json = jsonDecode(request.body);
    final creditModel = TmdbCreditModel.fromMap(json);
    return creditModel as T;
  }
}
