import 'package:movie_catalog/user/user_controller.dart';

void main() async {
  UserController.getToken().then((value) => print(value));
}