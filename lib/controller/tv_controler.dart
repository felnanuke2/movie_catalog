import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/model/movie_item_model.dart';
import 'package:movie_catalog/model/credit_model.dart';
import 'package:movie_catalog/model/movie_video_model.dart';
import 'package:movie_catalog/model/tv_model.dart';

class TvController {
  TvModel? tvModel;
  CreditModel? creditModel;
  List<MovieVideoModel> videoList = [];
  List<MovieItemModel> similarTVList = [];
  var _tvController = StreamController<TvModel>.broadcast();
  var _creditController = StreamController<CreditModel>.broadcast();
  var _videController = StreamController<List<MovieVideoModel>>.broadcast();
  var _similarController = StreamController<List<MovieItemModel>>.broadcast();

  Stream<TvModel> get tvStream => _tvController.stream;

  Stream<CreditModel> get creditStream => _creditController.stream;

  Stream<List<MovieVideoModel>> get videosStream => _videController.stream;

  Stream<List<MovieItemModel>> get similarListStream => _similarController.stream;

  getData(String id) {
    _getTvModel(id);
    _getCredits(id);
    _getVideos(id);
    _getSimilar(id);
  }

  Future<TvModel> _getTvModel(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?api_key=123cfdbadaa769bb037ba5a7a828a63a&language=pt-BR'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      try {
        tvModel = TvModel.fromJson(json);
      } catch (e) {}
    }
    _tvController.add(tvModel!);
    return tvModel!;
  }

  Future<CreditModel> _getCredits(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/credits?api_key=123cfdbadaa769bb037ba5a7a828a63a&language=pt-BR'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      try {
        creditModel = CreditModel.fromJson(json);
      } catch (e) {
        print(e);
      }
    }
    _creditController.add(creditModel!);
    return creditModel!;
  }

  Future<List<MovieVideoModel>> _getVideos(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/videos?api_key=123cfdbadaa769bb037ba5a7a828a63a'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      try {
        videoList = List.from(json['results']).map((e) => MovieVideoModel.fromJson(e)).toList();
        videoList.removeWhere((element) => element.site != 'YouTube');
      } catch (e) {
        print(e);
      }
    }
    _videController.add(videoList);
    return videoList;
  }

  Future<List<MovieItemModel>> _getSimilar(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/similar?api_key=123cfdbadaa769bb037ba5a7a828a63a'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      try {
        similarTVList = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    }
    _similarController.add(similarTVList);
    return similarTVList;
  }
}
