import 'package:movie_catalog/core/interfaces/auth_interface.dart';
import 'package:movie_catalog/core/interfaces/movies_interface.dart';
import 'package:movie_catalog/core/interfaces/persistence_interface.dart';
import 'package:movie_catalog/core/interfaces/tv_interface.dart';
import 'package:movie_catalog/core/interfaces/user_interface.dart';
import 'package:movie_catalog/core/model/base_user.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

class Api {
  final AuthRepoInterface _auth;
  final MoviesRepoInterface _movies;
  final TvRepoInterface _series;
  final UserInterface _user;
  final PersistenceInterface _persistence;

  Api(
    this._auth,
    this._movies,
    this._series,
    this._user,
    this._persistence,
  );

  BaseUser? get currentUser => _user.currentUser;

  Future initialize() async {
    await _persistence.init();
  }

  Future signIn(String sessionId) => _auth.signIn(sessionId);

  Future singnOut() => _auth.signOut();

  Future<List<MovieItemModel>> getPopularMovies({int page = 1}) =>
      _movies.getPopularMovies(page: page);
  Future<List<MovieItemModel>> getPlayNowMovies({int page = 1}) =>
      _movies.getPlayNowMovies(page: page);
  Future<List<MovieItemModel>> getTopRatedMovies({int page = 1}) =>
      _movies.getTopRated(page: page);
  Future<List<MovieItemModel>> getUpcomingMovies({int page = 1}) =>
      _movies.getUpcomingMovies(page: page);
  Future<List<MovieItemModel>> searchMovies(String query) =>
      _movies.search(query);

  Future<List<MovieItemModel>> getPopularTvShows({int page = 1}) =>
      _series.getPopularTvshows(page: page);
  Future<List<MovieItemModel>> getLatestTvShow({int page = 1}) =>
      _series.getLatestTvshows();
  Future<List<MovieItemModel>> getTopRatedTvShow({int page = 1}) =>
      _series.getTopRatedTvshows(page: page);

  Future<List<MovieItemModel>> searchTvShow(String query) =>
      _series.search(query);

  Future<String> createSession() => _auth.createSession();
}
