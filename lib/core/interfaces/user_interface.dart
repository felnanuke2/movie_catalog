import 'package:movie_catalog/core/model/base_user.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

abstract class UserInterface {
  BaseUser? get currentUser;

  Future<List<MovieItemModel>> getMoviesWachList({bool? add, int page = 1});

  Future<List<MovieItemModel>> getMoviesFavorites({bool? add, int page = 1});

  Future<List<MovieItemModel>> getMoviesRated({bool? add, int page = 1});

  Future<List<MovieItemModel>> getTvWachList({bool? add, int page = 1});

  Future<List<MovieItemModel>> getTvFavorites({bool? add, int page = 1});

  Future<List<MovieItemModel>> getTvRated({bool? add, int page = 1});

  Future<MovieItemModel> markAsFavorite(
      bool favorite, String mediaType, MovieItemModel movieItemModel);

  Future<MovieItemModel> addToWatchList(
      bool watchlist, String mediaType, MovieItemModel movieItemModel);

  Future<MovieItemModel> rateMovie(MovieItemModel movieItemModel, num rate);

  Future<MovieItemModel> rateSerie(MovieItemModel movieItemModel, num rate);
}
