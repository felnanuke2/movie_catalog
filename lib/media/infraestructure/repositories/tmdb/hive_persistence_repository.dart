// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:movie_catalog/core/interfaces/persistence_interface.dart';
// import 'package:movie_catalog/core/model/base_user.dart';

// const _USER_BOX = 'user_box';
// const CURRENT_USER = 'current_user';

// class HivePersistenceRepository implements PersistenceInterface {
//   late Box<BaseUser?> _userBox;
//   @override
//   Future<void> init() async {
//     await Hive.initFlutter();
//     Hive.registerAdapter(BaseUserAdapter());
//     _userBox = await Hive.openBox(_USER_BOX);
//   }

//   @override
//   Future<void> clearUser() async {
//     await _userBox.clear();
//   }

//   @override
//   BaseUser? get currentUser => _userBox.get(CURRENT_USER);

//   @override
//   Future<BaseUser?> saveUser(BaseUser? user) async {
//     await _userBox.put(CURRENT_USER, user);
//   }
// }
