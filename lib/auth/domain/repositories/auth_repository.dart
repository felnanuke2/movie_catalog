import 'package:dartz/dartz.dart';
import 'package:movie_catalog/auth/domain/entities/user.dart';
import 'package:movie_catalog/auth/domain/entities/user_auth.dart';
import 'package:movie_catalog/auth/domain/error/auth_request_error.dart';
import 'package:movie_catalog/auth/domain/error/local_sotorage_error.dart';
import 'package:movie_catalog/auth/domain/error/unauthenticated_user_error.dart';

/// responsible for authenticating the user in the app and authenticating requests in context
abstract class AuthRepository {
  Either<AuthUnauthenticatedError, UserAuthEntity> get getUserAuth;

  /// if
  /// ```
  ///  Future<String> requestToken({String? redirectTo})
  /// ```
  /// was used the resulting token must be entered here in order to create a session and get a user
  Future<Either<AuthRequestError, UserEntity>> signIn({required String token});

  Future<Either<AuthLocalStorageError, void>> signOut();
}
