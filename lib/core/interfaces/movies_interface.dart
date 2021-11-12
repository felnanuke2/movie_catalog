import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';

abstract class MoviesRepoInterface {
  Future<List<MovieItemModel>> getPopularMovies({int page = 1});
  Future<List<MovieItemModel>> getUpcomingMovies({int page = 1});
  Future<List<MovieItemModel>> search(String query);
  Future<List<MovieItemModel>> getPlayNowMovies({int page = 1});
  Future<List<MovieItemModel>> getTopRated({int page = 1});
  Future<CreditModel> getCredits(
    String movieId,
  );
  Future<MovieModelDetail> getDetails(String id);
  Future<List<MovieVideoModel>> getVideosList(String id);
  Future<List<MovieItemModel>> getRecomendations(String id);
}
