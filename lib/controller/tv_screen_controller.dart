import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/model/base_user.dart';
import 'package:movie_catalog/core/model/credit_model.dart';

import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/core/model/tv_model.dart';

class TvScreenController extends GetxController {
  MovieItemModel movieItemModel;
  late Future<TvModel> tvModel;
  late Future<CreditModel> creditModel;
  late Future<List<MovieVideoModel>> movieVideos;
  final Api _api = Get.find();

  TvScreenController({
    required this.movieItemModel,
  }) {
    final id = (movieItemModel.id ?? 0).toString();
    tvModel = _api.getTvModel(id);
    creditModel = _api.getCreditModel(id);
    movieVideos = _api.getTvVideos(id);
  }

  final loadingData = false.obs;

  BaseUser? get currentUser => _api.currentUser;

  final expandedOverview = false.obs;

  Stream<List<MovieItemModel>> getSimilarTvList() async* {
    final suggestions =
        await _api.getSimilarTvShow(movieItemModel.id.toString());
    yield suggestions;
  }

  void expandeOverview() => expandedOverview.value = !expandedOverview.value;
}
