import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

class TvController extends GetxController {
  final Api api = Get.find();

  final popularList = <MovieItemModel>[].obs;

  final latestTvList = <MovieItemModel>[].obs;

  final topratedTvList = <MovieItemModel>[].obs;

  int popularPage = 0;
  int latestPage = 0;
  int topRatedPage = 0;

  Future<List<MovieItemModel>> getPopularTvList({bool? add}) async {
    final list = await api.getPopularTvShows(page: ++popularPage);
    popularList.addAll(list);
    return list;
  }

  Future<List<MovieItemModel>> getLatestTvList({bool? add}) async {
    final list = await api.getLatestTvShow(page: ++latestPage);
    latestTvList.addAll(list);
    return list;
  }

  Future<List<MovieItemModel>> getTopRatedTvList({bool? add}) async {
    final list = await api.getTopRatedTvShow(page: ++topRatedPage);
    topratedTvList.addAll(list);
    return list;
  }
}
