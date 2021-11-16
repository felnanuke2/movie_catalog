import 'package:movie_catalog/core/model/base_user.dart';

abstract class PersistenceInterface {
  Future<void> init();

  BaseUser? get currentUser;
  Future<BaseUser?> saveUser(BaseUser? user);
  Future<void> clearUser();
}
