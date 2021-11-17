import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/constant/constant.dart';
import 'package:movie_catalog/controller/session_controller.dart';
import 'package:movie_catalog/core/api/api.dart';

class LoginController extends GetxController {
  final AnimationController _animationController;
  final Api _api = Get.find();
  final SessionController _sessionController = Get.find();
  LoginController(this._animationController);
  Future<void> login() async {
    _animationController.reverse();
    final url =
        await _api.requestToken(redirectTo: '$CALL_BACK_SCHEME://login/');
    try {
      final response = await FlutterWebAuth.authenticate(
          url: url, callbackUrlScheme: CALL_BACK_SCHEME);
      final uri = Uri.parse(response);
      final token = uri.queryParameters['request_token'];
      await _api.signIn(token: token!);
      _sessionController.currentUser.value = _api.currentUser;
    } catch (e) {
      _animationController.forward();
    }
  }
}
