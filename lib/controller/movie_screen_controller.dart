import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/core/interfaces/auth_interface.dart';
import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';

class MovieScreenController extends GetxController {
  final movieModelDetail = Rx<MovieModelDetail?>(null);
  final expandedOverview = false.obs;
  final meditype = 'movie';
  final awaiting = false.obs;
  bool get isAuthenticated => Get.find<AuthRepoInterface>().getUserAuth != null;
  final creditModel = Rx<CreditModel?>(null);
  final videosList = <MovieVideoModel>[];
  final recomendationsList = <MovieItemModel>[].obs;

  String? get director =>
      creditModel.value == null || creditModel.value?.crew == null
          ? null
          : creditModel.value!.crew!
              .firstWhere((element) => element.job == 'Director')
              .name;

  void toggleOverView() => expandedOverview.value = !expandedOverview.value;
}
