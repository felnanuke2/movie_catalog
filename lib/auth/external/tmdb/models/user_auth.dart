import 'package:movie_catalog/auth/domain/entities/user_auth.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';

/// this is a class responsible for authenticate the requests/
/// most of time is abstracted and extended for another class like ``` TmdbUserAuth ```
/// this can be adapted for any repositry when is extended.
class TmdbUserAuth extends UserAuthEntity {
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
  final String userId;
  final String sessionId;

  TmdbUserAuth({
    required this.userId,
    required this.sessionId,
  }) : super(token: sessionId);
}
