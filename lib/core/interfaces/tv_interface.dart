import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/core/model/tv_model.dart';

abstract class TvRepoInterface {
  Future<List<MovieItemModel>> getPopularTvshows({int page = 1});
  Future<List<MovieItemModel>> getLatestTvshows({int page = 1});
  Future<List<MovieItemModel>> getTopRatedTvshows({int page = 1});
  Future<List<MovieItemModel>> search(String query);
  Future<List<MovieItemModel>> getSimilar(String id);
  Future<List<MovieVideoModel>> getVideos(String id);
  Future<CreditModel> getCredits(String id);
  Future<TvModel> getTvModel(String id);
}
