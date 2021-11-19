import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/core/interfaces/tv_interface.dart';
import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/core/model/tv_model.dart';

class TmdbTvRepository implements TvRepoInterface {
  @override
  Future<List<MovieItemModel>> getLatestTvshows({int page = 1}) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/on_the_air?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final latest = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return latest;
  }

  @override
  Future<List<MovieItemModel>> getPopularTvshows({int page = 1}) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/popular?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    final json = jsonDecode(request.body);
    final popularTvList = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return popularTvList;
  }

  @override
  Future<List<MovieItemModel>> getTopRatedTvshows({int page = 1}) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final topRatedTvList = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return topRatedTvList;
  }

  @override
  Future<List<MovieItemModel>> search(String query) async {
    final request = await get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language= pt-br&query=$query'));
    if (request.statusCode != 200) throw request.body;
    final json = jsonDecode(request.body);
    final search = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    search.sort((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    });
    return search;
  }

  @override
  Future<TvModel> getTvModel(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?api_key=$API_KEY&language=pt-BR'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final tvModel = TvModel.fromJson(json);
    return tvModel;
  }

  @override
  Future<CreditModel> getCredits(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/credits?api_key=$API_KEY&language=pt-BR'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final creditModel = CreditModel.fromJson(json);
    return creditModel;
  }

  @override
  Future<List<MovieVideoModel>> getVideos(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/videos?api_key=$API_KEY'));
    if (request.statusCode == 200) throw request.body;

    var json = jsonDecode(request.body);

    final videoList = List.from(json['results'])
        .map((e) => MovieVideoModel.fromJson(e))
        .toList();
    videoList.removeWhere((element) => element.site != 'YouTube');

    return videoList;
  }

  @override
  Future<List<MovieItemModel>> getSimilar(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id/similar?api_key=$API_KEY'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final similarTVList = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return similarTVList;
  }

  @override
  Future<MovieModelDetail> getDetails(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/$id?api_key=$API_KEY&language=pt-br'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final movieModelDetail = MovieModelDetail.fromJson(json);
    return movieModelDetail;
  }
}
