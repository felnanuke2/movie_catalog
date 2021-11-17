import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/interfaces/auth_interface.dart';
import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';

class MovieScreenController extends GetxController {
  MovieScreenController(this.movieItem) {
    final id = movieItem.id.toString();
    movieModelDetail = _api.getMovieDetails(id: id);
    creditModel = _api.getMovieCreditModel(id);
  }
  final MovieItemModel movieItem;
  final Api _api = Get.find();
  late Future<MovieModelDetail> movieModelDetail;
  final expandedOverview = false.obs;
  final meditype = 'movie';
  final awaiting = false.obs;
  bool get isAuthenticated => Get.find<AuthRepoInterface>().getUserAuth != null;
  late Future<CreditModel> creditModel;
  final videosList = <MovieVideoModel>[];
  final recomendationsList = <MovieItemModel>[].obs;

  String? getDirector(CreditModel credit) =>
      credit.crew!.firstWhere((element) => element.job == 'Director').name;

  void toggleOverView() => expandedOverview.value = !expandedOverview.value;
}
