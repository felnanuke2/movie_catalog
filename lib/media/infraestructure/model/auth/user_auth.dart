import 'package:movie_catalog/core/model/auth/tmdb_user_auth.dart';

/// this is a class responsible for authenticate the requests/
/// most of time is abstracted and extended for another class like ``` TmdbUserAuth ```
/// this can be adapted for any repositry when is extended.
class UserAuth {
  ///this args is a generic args and you can use this args to create a extended class.
  ///See:
  ///```
  ///  TmdbUserAuth? asTmdbAuth() {
  ///   try {
  ///     return TmdbUserAuth.fromArgs(args);
  ///   } catch (e) {
  ///     return null;
  ///   }
  /// }
  ///```
  final Map args;
  UserAuth({
    required this.args,
  });

  /// Adapt
  /// ```
  /// this.UserAuth
  /// ```
  ///  to a
  /// TmdbUserAuth

  ///  use
  /// ```
  /// this.args
  /// ```
  /// to create this.
  TmdbUserAuth? asTmdbAuth() {
    try {
      return TmdbUserAuth.fromArgs(args);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}
