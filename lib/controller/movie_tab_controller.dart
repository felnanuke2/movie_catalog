import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

class MovieTabController extends GetxController {
  final Api api = Get.find();
  final popularMovies = <MovieItemModel>[].obs;
  final upcomingMovies = <MovieItemModel>[].obs;
  final onAirMovies = <MovieItemModel>[].obs;
  final topRatedMovies = <MovieItemModel>[].obs;
  int popularPage = 0;
  int upcomingPage = 0;
  int playNowPage = 0;
  int topRatedPage = 0;

  Future<List<MovieItemModel>> getPopularMovies({bool? add}) async {
    final list = await api.getPopularMovies(page: ++popularPage);
    popularMovies.addAll(list);
    return list;
  }

  Future<List<MovieItemModel>> getPLayNowMovies({bool? add}) async {
    final list = await api.getPlayNowMovies(page: ++playNowPage);
    onAirMovies.addAll(list);
    return list;
  }

  Future<List<MovieItemModel>> getTopRatedMovies({bool? add}) async {
    final list = await api.getTopRatedMovies(page: ++topRatedPage);
    topRatedMovies.addAll(list);
    return list;
  }

  Future<List<MovieItemModel>> getUpcomingMovies({bool? add}) async {
    final list = await api.getUpcomingMovies(page: ++upcomingPage);
    upcomingMovies.addAll(list);
    return list;
  }
}
