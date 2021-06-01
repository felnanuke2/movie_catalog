import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/moviescreen/model/actor_model.dart';
import 'package:movie_catalog/moviescreen/model/movie_video_model.dart';
import 'package:movie_catalog/tvscreen/models/tv_model.dart';

class TvController {
  TvModel? tvModel;
  CreditModel? creditModel;
  List<MovieVideoModel> videoList = [];
  List<MovieItemModel> similarTVList = [];
  var _tvController = StreamController<String>.broadcast();

  set tvId(String id) => _tvController.add(id);

  Stream<TvModel> get tvStream =>
      _tvController.stream.asyncMap((event) async => await _getTvModel(event));

  Stream<CreditModel> get creditStream =>
      _tvController.stream.asyncMap((event) async => await _getCredits(event));

  Stream<List<MovieVideoModel>> get videosStream =>
      _tvController.stream.asyncMap((event) async => await _getVideos(event));

  Stream<List<MovieItemModel>> get similarListStream =>
      _tvController.stream.asyncMap((event) async => await _getSimilar(event));

  Future<TvModel> _getTvModel(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?api_key=123cfdbadaa769bb037ba5a7a828a63a&language=pt-BR'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      try {
        tvModel = TvModel.fromJson(json);
      } catch (e) {
        print(e);
      }
    }
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
    return similarTVList;
  }
}
