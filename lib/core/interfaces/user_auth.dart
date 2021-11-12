import 'package:movie_catalog/core/model/auth/tmdb_user_auth.dart';

class UserAuth {
  final Map args;
  UserAuth({
    required this.args,
  });

  TmdbUserAuth? asTmdbAuth() {
    try {
      return TmdbUserAuth.fromArgs(args);
    } catch (e) {
      return null;
    }
  }
}
