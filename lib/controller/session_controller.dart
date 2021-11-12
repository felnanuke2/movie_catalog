import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:movie_catalog/core/model/base_user.dart';

class SessionController extends GetxController {
  final currentUser = Rx<BaseUser?>(null);
}
