import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/model/base_user.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

class SessionController extends GetxController {
  SessionController() {
    currentUser.value = _api.currentUser;
  }
  final Api _api = Get.find();

  final currentUser = Rx<BaseUser?>(null);

  get tvFavorites => [];

  get tvWhactList => [];

  get tvRated => [];

  get movieFavorites => [];

  get movieWhactList => [];

  get movieRated => [];

  void markAsFavorite(bool bool, String s, MovieItemModel movieItemModel) {}

  void addToWatchList(bool wachList, String s, MovieItemModel movieItemModel) {}

  void rateSerie(MovieItemModel movieItemModel, num parse) {}

  void rateMovie(MovieItemModel movieItemModel, num parse) {}
}
