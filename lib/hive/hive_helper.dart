import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  static setCurrentUser(String name, String userName, bool incudeAdult, String sessionID) async {
    var baseUser =
        BaseUser(incudeAdult: incudeAdult, name: name, userName: userName, sessionID: sessionID);
    await _box!.put('current_user', baseUser);
    print(_box!.values);
  }

  static BaseUser? getBaseUser() {
    return _box!.get('current_user');
  }
}
