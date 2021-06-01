class UserModel {
  UserModel._internal();
  static final _instance = UserModel._internal();
  static UserModel get instance => _instance;
}
