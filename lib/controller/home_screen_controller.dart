import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';

class HomeScreenController {
  static var _apiKey = '123cfdbadaa769bb037ba5a7a828a63a';
  //LISTS MOVIES
  static List<MovieItemModel> popularMovies = [];
  static List<MovieItemModel> upcomingMovies = [];
  static List<MovieItemModel> searchMoviesStorage = [];
  static List<MovieItemModel> playnowMovies = [];
  static List<MovieItemModel> topRatedMovies = [];
  //STREAM CONTROLERS MOVIES
  final _searchStreamController = StreamController<List<String>>.broadcast();
  static final _popularMovieSController = StreamController<List<MovieItemModel>>.broadcast();
  static final _upcomingMovieSController = StreamController<List<MovieItemModel>>.broadcast();
  static final _nowPlayngMovieSController = StreamController<List<MovieItemModel>>.broadcast();
  static final _topRatedMovieSController = StreamController<List<MovieItemModel>>.broadcast();
  //PAGE COUNTER MOVIES
  static int _popularMoviesCurrentPage = 1;
  static int _upcomingMoviesCurrentPage = 1;
  static int _nowPlayngMoviesCurrentPage = 1;
  static int _topRatedMoviesCurrentPage = 1;

  //SETTER MOVIES
  ///send array of params to querry [0] is query String and [1] is type of Query
  ///use movie of tv.
  set queryStream(List<String> param) => _searchStreamController.sink.add(param);
  //GETTER MOVIES
  static Stream<List<MovieItemModel>> get popularMoviesStream => _popularMovieSController.stream;
  static Stream<List<MovieItemModel>> get upcomingMoviesStream => _upcomingMovieSController.stream;
  static Stream<List<MovieItemModel>> get playNowMoviesStream => _nowPlayngMovieSController.stream;
  static Stream<List<MovieItemModel>> get topRatedMoviesStream => _topRatedMovieSController.stream;

  Stream<List<MovieItemModel>> get searchStremResult =>
      _searchStreamController.stream.asyncMap((event) async {
        return await search(event[0], event[1]);
      });

  //FUNCTIONS MOVIES

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
      upcomingMovies
          .removeWhere((element) => popularMovies.map((e) => e.id).toList().contains(element.id));
    }
    _upcomingMovieSController.add(upcomingMovies);
    return upcomingMovies;
  }

  static Future<List<MovieItemModel>> search(String query, String type) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/search/$type?api_key=$_apiKey&language= pt-br&query=$query'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      searchMoviesStorage =
          List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList();
      searchMoviesStorage.sort((b, a) {
        return a.popularity!.compareTo(b.popularity!);
      });
    }
    if (searchMoviesStorage == null) searchMoviesStorage = [];
    return searchMoviesStorage;
  }

  static Future<List<MovieItemModel>> getPlayNowMovies({bool? add}) async {
    if (add == true) {
      _nowPlayngMoviesCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey&language=pt-br&page=$_nowPlayngMoviesCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      playnowMovies
          .addAll(List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList());
      playnowMovies.removeWhere((element) =>
          popularMovies.map((e) => e.id).toList().contains(element.id) ||
          upcomingMovies.map((e) => e.id).toList().contains(element.id));
      _nowPlayngMovieSController.add(playnowMovies);
    }
    return playnowMovies;
  }

  static Future<List<MovieItemModel>> getTopRated({bool? add}) async {
    if (add == true) {
      _topRatedMoviesCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey&language=pt-br&page=$_topRatedMoviesCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      topRatedMovies
          .addAll(List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList());
      topRatedMovies.removeWhere((element) =>
          popularMovies.map((e) => e.id).toList().contains(element.id) ||
          upcomingMovies.map((e) => e.id).toList().contains(element.id) ||
          playnowMovies.map((e) => e.id).toList().contains(element.id));
      topRatedMovies.sort((a, b) => b.popularity!.compareTo(a.popularity!));
      _topRatedMovieSController.add(topRatedMovies);
    }
    return topRatedMovies;
  }

//LIST TVSHOWS
  static List<MovieItemModel> popularTvList = [];
  static List<MovieItemModel> ontheAirTvList = [];
  static List<MovieItemModel> topRatedTvList = [];

//STREAMS TVSHOWS
  static var _popularTvShowStream = StreamController<List<MovieItemModel>>.broadcast();
  static var _ontheAirTvShowStream = StreamController<List<MovieItemModel>>.broadcast();
  static var _topRatedTvShowStream = StreamController<List<MovieItemModel>>.broadcast();

//GETTER TV SHOW
  static Stream<List<MovieItemModel>> get popularTvStream => _popularTvShowStream.stream;
  static Stream<List<MovieItemModel>> get latesTvStream => _ontheAirTvShowStream.stream;
  static Stream<List<MovieItemModel>> get topRatedTvStream => _topRatedTvShowStream.stream;
  // CURRENT PAGE TV SHOWS
  static int _popularTvShowsCurrentPage = 1;
  static int _onTheAirTvShowsCurrentPage = 1;
  static int _topRatedTvShowsCurrentPage = 1;

  //FUNCTIONS TV SHOW
  static Future<List<MovieItemModel>> getPopularTvshows({bool? add}) async {
    if (add == true) {
      _popularTvShowsCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey&language=pt-br&page=$_popularTvShowsCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      popularTvList
          .addAll(List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList());
      _popularTvShowStream.add(popularTvList);
    }
    return popularTvList;
  }

  static Future<List<MovieItemModel>> getLatestTvshows({bool? add}) async {
    if (add == true) {
      _onTheAirTvShowsCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/on_the_air?api_key=$_apiKey&language=pt-br&page=$_popularTvShowsCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      ontheAirTvList
          .addAll(List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList());
      _ontheAirTvShowStream.add(ontheAirTvList);
    }
    return ontheAirTvList;
  }

  static Future<List<MovieItemModel>> getTopRatedTvshows({bool? add}) async {
    if (add == true) {
      _topRatedTvShowsCurrentPage += 1;
    }
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=$_apiKey&language=pt-br&page=$_popularTvShowsCurrentPage'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      topRatedTvList
          .addAll(List.from(json['results']).map((e) => MovieItemModel.fromJson(e)).toList());
      _topRatedTvShowStream.add(topRatedTvList);
    }
    return topRatedTvList;
  }
}
