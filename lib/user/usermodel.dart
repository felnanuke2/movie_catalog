import 'package:movie_catalog/hive/hive_helper.dart';
import 'package:movie_catalog/user/base_user.dart';

class UserModel {
  UserModel._internal() {
    this.baseUser = HiveHelper.getBaseUser();
  }
  static final _instance = UserModel._internal();
  static UserModel get instance => _instance;
  BaseUser? baseUser;
  //Get TV Show Watchlist
  //Get Movie Watchlist
  //Get Rated TV Shows
  //Get Rated Movies
}
