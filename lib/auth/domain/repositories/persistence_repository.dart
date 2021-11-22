import 'package:dartz/dartz.dart';
import 'package:movie_catalog/auth/domain/entities/user.dart';
import 'package:movie_catalog/auth/domain/error/local_sotorage_error.dart';

/// This repository is responsible to persisting any data in a local device like ``` Tokens ``` or something
abstract class AuthPersistenceRepository {
  /// this is responsible to inilialize a ```Db``` whatever it is.
  /// this method needs to be called before anyone else or will broke.
  ///
  /// ```Hint```: TENSURE THAT YOUR REPOSITORY IS INITIALIZED.
  Future<Either<AuthLocalStorageError, void>> init();

  /// Get ```currentUser``` persited in local storage.
  Either<AuthLocalStorageError, UserEntity> get currentUser;

  /// save the currentuser async in LocalStorage to persisted.
  Future<Either<AuthLocalStorageError, UserEntity>> saveUser(UserEntity user);

  /// this will clear you storage.
  /// this can be used to clear a session.
  /// probably this will call from a ``` signOut() ``` method in another class.
  Future<Either<AuthLocalStorageError, void>> clearUser();
}
