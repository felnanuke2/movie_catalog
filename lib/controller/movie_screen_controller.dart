import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/model/movie_item_model.dart';
import 'package:movie_catalog/model/credit_model.dart';
import 'package:movie_catalog/model/movie_model_detailed.dart';
import 'package:movie_catalog/model/movie_video_model.dart';

class MovieScreenController {
  CreditModel? creditModel;
  MovieModelDetail? movieModelDetail;
  List<MovieVideoModel> listVideoModel = [];
  List<MovieItemModel> recomendationsList = [];

  var _videosController = StreamController<List<MovieVideoModel>>.broadcast();
  var _creditController = StreamController<CreditModel>.broadcast();
  var _detailsController = StreamController<MovieModelDetail>.broadcast();
  var _recomendationController = StreamController<List<MovieItemModel>>.broadcast();

  void getData(String id) {
    _getVideosList(id);
    _getDetails(id);
    _getCredits(id);
    _getRecomendations(id);
  }

  //GETTER
  Stream<CreditModel> get movieCreditStream => _creditController.stream;
  Stream<MovieModelDetail> get movieDetailStream => _detailsController.stream;

  Stream<List<MovieVideoModel>> get listVideosStream => _videosController.stream;

  Stream<List<MovieItemModel>> get recomendationsStream => _recomendationController.stream;

  //FUNCTIONS

  Future<CreditModel> _getCredits(
    String movieId,
  ) async {
    var request = await get(
        Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits?api_key=123cfdbadaa'
            '769bb037ba5a7a828a63a&language=pt-br'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      creditModel = CreditModel.fromJson(json);

      creditModel!.cast!.sort((b, a) {
        return a.popularity!.compareTo(b.popularity!);
      });
    }
    _creditController.add(creditModel!);
    return creditModel!;
  }

  Future<MovieModelDetail> _getDetails(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=123cfdbadaa769bb037ba5a7a828a63a&language=pt-br'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      movieModelDetail = MovieModelDetail.fromJson(json);
    }
    _detailsController.add(movieModelDetail!);
    return movieModelDetail!;
  }

  Future<List<MovieVideoModel>> _getVideosList(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=123cfdbadaa769bb037ba5a7a828a63a'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      this.listVideoModel =
          List.from(json['results']).map((e) => MovieVideoModel.fromJson(e)).toList();
      this.listVideoModel.removeWhere((element) => element.site != 'YouTube');
    }
    print('get video');
    _videosController.add(listVideoModel);
    return this.listVideoModel;
  }

  Future<List<MovieItemModel>> _getRecomendations(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=123cfdbadaa769bb037ba5a7a828a63a&language=pt-br'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      this.recomendationsList =
          List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      recomendationsList.sort((b, a) {
        return a.popularity!.compareTo(b.popularity!);
      });
    }
    _recomendationController.add(recomendationsList);
    return recomendationsList;
  }
}
