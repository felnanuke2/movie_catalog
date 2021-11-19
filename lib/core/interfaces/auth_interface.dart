import 'package:movie_catalog/core/interfaces/user_auth.dart';
import 'package:movie_catalog/core/model/base_user.dart';

/// responsible for authenticating the user in the app and authenticating requests in context
abstract class AuthRepoInterface {
  UserAuth? get getUserAuth;

  /// if
  /// ```
  ///  Future<String> requestToken({String? redirectTo})
  /// ```
  /// was used the resulting token must be entered here in order to create a session and get a user
  Future<BaseUser> signIn({required String token});

  Future<void> signOut();

  /// may or may not need to be used but you should get an access token from an external auth service with [TMDB]
  Future<String> requestToken({String? redirectTo});
}
