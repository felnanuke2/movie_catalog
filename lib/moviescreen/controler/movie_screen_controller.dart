import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/moviescreen/model/actor_model.dart';
import 'package:movie_catalog/moviescreen/model/movie_model_detailed.dart';
import 'package:movie_catalog/moviescreen/model/movie_video_model.dart';

class MovieScreenController {
  CreditModel? creditModel;
  MovieModelDetail? movieModelDetail;
  List<MovieVideoModel> listVideoModel = [];
  List<MovieItemModel> recomendationsList = [];
  var _movieStreamController = StreamController<String>.broadcast();
//SETER
  set movieID(String id) => _movieStreamController.sink.add(id);
  //GETTER
  Stream<CreditModel> get movieCreditStream =>
      _movieStreamController.stream.asyncMap((event) async {
        return await _getCredits(event);
      });
  Stream<MovieModelDetail> get movieDetailStream =>
      _movieStreamController.stream.asyncMap((event) => _getGenders(event));

  Stream<List<MovieVideoModel>> get listVideosStream =>
      _movieStreamController.stream.asyncMap((event) async => await _getVideosList(event));

  Stream<List<MovieItemModel>> get recomendationsStream =>
      _movieStreamController.stream.asyncMap((event) async => await _getRecomendations(event));

  //FUNCTIONS

  Future<CreditModel> _getCredits(String movieId, {bool? director}) async {
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
    return creditModel!;
  }

  Future<MovieModelDetail> _getGenders(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=123cfdbadaa769bb037ba5a7a828a63a&language=pt-br'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      movieModelDetail = MovieModelDetail.fromJson(json);
    }
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
    return recomendationsList;
  }
}
