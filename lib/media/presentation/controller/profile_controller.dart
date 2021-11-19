import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/controller/session_controller.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/model/base_user.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:get/state_manager.dart';

class ProfileController extends GetxController {
  final Api _api = Get.find();
  final SessionController _sessionController = Get.find();

  final TickerProvider vsync;
  ProfileController({
    required this.vsync,
  }) {
    serieOrTvTabController = TabController(length: 2, vsync: vsync);
    moviesTabController = TabController(length: 3, vsync: vsync);
    seriesTabController = TabController(length: 3, vsync: vsync);
  }

  BaseUser? get user => _api.currentUser;
  late TabController serieOrTvTabController;
  late TabController moviesTabController;
  late TabController seriesTabController;

  final movieWhactList = <MovieItemModel>[].obs;

  final movieFavorites = <MovieItemModel>[].obs;

  final movieRated = <MovieItemModel>[].obs;

  final tvWhactList = <MovieItemModel>[].obs;

  final tvFavorites = <MovieItemModel>[].obs;

  final tvRated = <MovieItemModel>[].obs;

  void getMoviesWachList({bool? add}) {}

  void getMoviesFavorites({bool? add}) {}

  void getMoviesRated({bool? add}) {}

  void getTvWachList({bool? add}) {}

  void getTvFavorites({bool? add}) {}

  void getTvRated({bool? add}) {}

  void signOut() async {
    await _api.singnOut();
    _sessionController.currentUser.value = _api.currentUser;
  }
}
