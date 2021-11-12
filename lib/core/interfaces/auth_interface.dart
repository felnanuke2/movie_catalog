import 'package:movie_catalog/core/interfaces/user_auth.dart';
import 'package:movie_catalog/core/model/base_user.dart';

abstract class AuthRepoInterface {
  Future<void> initilize();
  Future<BaseUser> signIn(String sessionId);
  Future<void> signOut();
  UserAuth? get getUserAuth;
  Future<String> createSession();
}
