import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/user/usermodel.dart';

class ProfileController {
  //LISTS
  static List<MovieItemModel> movieWhactList = [];
  static List<MovieItemModel> movieFavorites = [];
  static List<MovieItemModel> movieRated = [];
  static List<MovieItemModel> tvWhactList = [];
  static List<MovieItemModel> tvFavorites = [];
  static List<MovieItemModel> tvRated = [];

  //PAGECOUNTERS
  static int _moviesWhachCurrentPage = 1;
  static int _moviesFavoritesCurrentPage = 1;
  static int _moviesRatedCurrentPage = 1;
  static int _tvWhachCurrentPage = 1;
  static int _tvFavoritesCurrentPage = 1;
  static int _tvRatedCurrentPage = 1;

  //STREAMCONTROLLERS
  static var movieWarchController = StreamController<List<MovieItemModel>>.broadcast();
  static var movieFavoritesController = StreamController<List<MovieItemModel>>.broadcast();
  static var movieRatedController = StreamController<List<MovieItemModel>>.broadcast();
  static var tvWarchController = StreamController<List<MovieItemModel>>.broadcast();
  static var tvFavoritesController = StreamController<List<MovieItemModel>>.broadcast();
  static var tvRatedController = StreamController<List<MovieItemModel>>.broadcast();

  //GETTERS
  static Stream<List<MovieItemModel>> get moviesWachListController => movieWarchController.stream;
  static Stream<List<MovieItemModel>> get moviesFavoritesListController =>
      movieFavoritesController.stream;
  static Stream<List<MovieItemModel>> get moviesRatedListController => movieRatedController.stream;
  static Stream<List<MovieItemModel>> get tvWachListController => tvWarchController.stream;
  static Stream<List<MovieItemModel>> get tvFavoritesListController => tvFavoritesController.stream;
  static Stream<List<MovieItemModel>> get tvRatedListController => tvRatedController.stream;

//FUNCTIONS
  static void getMoviesWachList({bool? add}) async {
    if (add == true) {
      _moviesWhachCurrentPage += 1;
    }
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    var requestURL = 'https://api.themoviedb.org/3/account/$id/watchlist'
        '/movies?api_key=123cfdbadaa769bb037ba5a7a828a63a&session_'
        'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$_moviesWhachCurrentPage';
    var request = await get(Uri.parse(requestURL));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var list = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      movieWhactList.addAll(list);
      movieWarchController.add(movieWhactList);
    }
  }

  static void getMoviesFavorites({bool? add}) async {
    if (add == true) {
      _moviesFavoritesCurrentPage += 1;
    }
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    var requestURL = 'https://api.themoviedb.org/3/account/$id/favorite'
        '/movies?api_key=123cfdbadaa769bb037ba5a7a828a63a&session_'
        'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$_moviesFavoritesCurrentPage';
    var request = await get(Uri.parse(requestURL));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var list = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      movieFavorites.addAll(list);
      movieFavoritesController.add(movieFavorites);
    }
  }

  static void getMoviesRated({bool? add}) async {
    if (add == true) {
      _moviesRatedCurrentPage += 1;
    }
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    var requestURL = 'https://api.themoviedb.org/3/account/$id/rated'
        '/movies?api_key=123cfdbadaa769bb037ba5a7a828a63a&session_'
        'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$_moviesRatedCurrentPage';
    var request = await get(Uri.parse(requestURL));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var list = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      movieRated.addAll(list);
      movieRatedController.add(movieRated);
    }
  }

  static void getTvWachList({bool? add}) async {
    if (add == true) {
      _tvWhachCurrentPage += 1;
    }
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    var requestURL = 'https://api.themoviedb.org/3/account/$id/watchlist'
        '/tv?api_key=123cfdbadaa769bb037ba5a7a828a63a&session_'
        'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$_tvWhachCurrentPage';
    var request = await get(Uri.parse(requestURL));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var list = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      tvWhactList.addAll(list);
      tvWarchController.add(tvWhactList);
    }
  }

  static void getTvFavorites({bool? add}) async {
    if (add == true) {
      _tvFavoritesCurrentPage += 1;
    }
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    var requestURL = 'https://api.themoviedb.org/3/account/$id/favorite'
        '/tv?api_key=123cfdbadaa769bb037ba5a7a828a63a&session_'
        'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$_tvFavoritesCurrentPage';
    var request = await get(Uri.parse(requestURL));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var list = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      tvFavorites.addAll(list);
      tvFavoritesController.add(tvFavorites);
    }
  }

  static void getTvRated({bool? add}) async {
    if (add == true) {
      _tvRatedCurrentPage += 1;
    }
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    var requestURL = 'https://api.themoviedb.org/3/account/$id/rated'
        '/tv?api_key=123cfdbadaa769bb037ba5a7a828a63a&session_'
        'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$_tvRatedCurrentPage';
    var request = await get(Uri.parse(requestURL));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var list = List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      tvRated.addAll(list);
      tvRatedController.add(tvRated);
    }
  }

  static cleanAllLists() {
    movieWhactList = [];
    movieFavorites = [];
    movieRated = [];
    tvWhactList = [];
    tvFavorites = [];
    tvRated = [];

    _moviesWhachCurrentPage = 1;
    _moviesFavoritesCurrentPage = 1;
    _moviesRatedCurrentPage = 1;
    _tvWhachCurrentPage = 1;
    _tvFavoritesCurrentPage = 1;
    _tvRatedCurrentPage = 1;
  }
}
