import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/core/model/tv_model.dart';

/// this repository is responsible for managing all request involving [Tv]
abstract class TvRepoInterface {
  /// get popular Tv and can be receive a index of ```page = 1``` if null
  Future<List<MovieItemModel>> getPopularTvshows({int page = 1});

  /// get latest TV and can be receive a index of ```page = 1``` if null

  Future<List<MovieItemModel>> getLatestTvshows({int page = 1});

  /// get topRated TV and can be receive a index of ```page = 1``` if null
  Future<List<MovieItemModel>> getTopRatedTvshows({int page = 1});

  /// Make a query and receive data the ``` query ```
  Future<List<MovieItemModel>> search(String query);

  /// Get The recommended or similar like a ```Movies``` or ```Series```
  Future<List<MovieItemModel>> getSimilar(String id);

  /// Get the related videos like ```Trailers``` ```MakingOf``` ...
  Future<List<MovieVideoModel>> getVideos(String id);

  /// need receive a ```tvId``` to get the credit of a Movie.
  /// the credit  contains ```Crew``` and ```Cast``` of a Src.
  Future<CreditModel> getCredits(String id);

  /// Need receive a ```tvId``` to get the tvDetails Specific ```TvModel```.
  Future<TvModel> getTvModel(String id);

  /// Need receive a ```tvId``` to get the tv Details.
  Future<MovieModelDetail> getDetails(String id);
}
