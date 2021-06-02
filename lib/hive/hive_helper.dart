import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/controller/profile_controller.dart';
import 'package:movie_catalog/user/base_user.dart';
import 'package:movie_catalog/user/usermodel.dart';

class HiveHelper {
  static Box<BaseUser>? _box;
  static init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(BaseUserAdapter());
    }
    _box = await Hive.openBox('user');
  }

  static setCurrentUser(String name, String userName, bool incudeAdult, String sessionID,
      String? avatar, int id) async {
    var baseUser = BaseUser(
        incudeAdult: incudeAdult,
        name: name,
        userName: userName,
        sessionID: sessionID,
        avatar: avatar,
        id: id);
    await _box!.put('current_user', baseUser);

    UserModel.instance.baseUser = baseUser;
    UserModel.instance.baseUserController!.add(baseUser);
    ProfileController.getMoviesWachList();
    ProfileController.getMoviesRated();
    ProfileController.getMoviesFavorites();
    ProfileController.getTvWachList();
    ProfileController.getTvRated();
    ProfileController.getTvFavorites();
  }

  static BaseUser? getBaseUser() {
    var currentUser = _box!.get('current_user');

    return currentUser;
  }

  static void loggout() {
    _box!.delete('current_user');
    UserModel.instance.baseUser = null;
    UserModel.instance.baseUserController!.add(null);
  }
}
