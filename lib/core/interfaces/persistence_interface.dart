import 'package:movie_catalog/core/model/base_user.dart';

/// This repository is responsible to persisting any data in a local device like ``` Tokens ``` or something
abstract class PersistenceInterface {
  /// this is responsible to inilialize a ```Db``` whatever it is.
  /// this method needs to be called before anyone else or will broke.
  ///
  /// ```Hint```: TENSURE THAT YOUR REPOSITORY IS INITIALIZED.
  Future<void> init();

  /// Get ```currentUser``` persited in local storage.
  BaseUser? get currentUser;

  /// save the currentuser async in LocalStorage to persisted.
  Future<BaseUser?> saveUser(BaseUser? user);

  /// this will clear you storage.
  /// this can be used to clear a session.
  /// probably this will call from a ``` signOut() ``` method in another class.
  Future<void> clearUser();
}
