import 'package:movie_catalog/core/interfaces/user_auth.dart';
import 'package:movie_catalog/core/model/base_user.dart';

abstract class AuthRepoInterface {
  UserAuth? get getUserAuth;

  Future<BaseUser> signIn(String sessionId);
  Future<void> signOut();
  Future<String> createSession();
}
