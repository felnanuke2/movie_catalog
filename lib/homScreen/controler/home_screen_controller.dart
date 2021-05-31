import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';

class HomeScreenController {
  static var _apiKey = '123cfdbadaa769bb037ba5a7a828a63a&language';
  static List<MovieItemModel> popularMovies = [];
  static List<MovieItemModel> upcomingMovies = [];
  static List<MovieItemModel> searchMoviesStorage = [];
  //STREAM CONTROLERS
  final _searchStreamController = StreamController<String>.broadcast();
  static final _popularMovieSController = StreamController<List<MovieItemModel>>.broadcast();
  static final _upcomingMovieSController = StreamController<List<MovieItemModel>>.broadcast();
  //PAGE COUNTER
  static int _popularMoviesCurrentPage = 1;
  static int _upcomingMoviesCurrentPage = 1;

  //SETTER
  set queryStream(String query) => _searchStreamController.sink.add(query);
  //GETTER
  static Stream<List<MovieItemModel>> get popularMoviesStream => _popularMovieSController.stream;
  static Stream<List<MovieItemModel>> get upcomingMoviesStream => _upcomingMovieSController.stream;

  Stream<List<MovieItemModel>> get searchStremResult =>
      _searchStreamController.stream.asyncMap((event) async {
        return await search(event);
      });

  //FUNCTIONS

  static Future<List<MovieItemModel>> getPopularMovies({bool? add}) async {
    if (add == true) {
      _popularMoviesCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=pt-br&page=$_popularMoviesCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var moviesList = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      popularMovies.addAll(moviesList);
    } else {
      popularMovies = [];
    }
    _popularMovieSController.add(popularMovies);
    return popularMovies;
  }

  static Future<List<MovieItemModel>> getUpcomingMovies({bool? add}) async {
    if (add == true) {
      _upcomingMoviesCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey&language=pt-br&page=$_upcomingMoviesCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var moviesList = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      upcomingMovies.addAll(moviesList);
    }
    _upcomingMovieSController.add(upcomingMovies);
    return upcomingMovies;
  }

  static Future<List<MovieItemModel>> search(String query) async {
    var request = await get(
        Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$_apiKey=pt-br&query=$query'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      searchMoviesStorage =
          List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
    }
    return searchMoviesStorage;
  }
}
