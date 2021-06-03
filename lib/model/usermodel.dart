import 'dart:async';

import 'package:movie_catalog/hive/hive_helper.dart';
import 'package:movie_catalog/controller/profile_controller.dart';
import 'package:movie_catalog/model/base_user.dart';

class UserModel {
  UserModel._internal() {
    this.baseUser = HiveHelper.getBaseUser();

    this.baseUserController = StreamController.broadcast();
    this.baseUserController!.add(baseUser);
  }
  static final _instance = UserModel._internal();
  static UserModel get instance => _instance;
  BaseUser? baseUser;
  StreamController<BaseUser?>? baseUserController;

  //Get TV Show Watchlist
  //Get Movie Watchlist
  //Get Rated TV Shows
  //Get Rated Movies
}
