import 'package:movie_catalog/core/interfaces/user_auth.dart';

class TmdbUserAuth extends UserAuth {
  TmdbUserAuth._(this.sessionId, this.userId) : super(args: {});

  final String userId;
  final String sessionId;

  factory TmdbUserAuth.fromArgs(Map args) {
    return TmdbUserAuth._(args['session_id'], args['user_id']);
  }
}
