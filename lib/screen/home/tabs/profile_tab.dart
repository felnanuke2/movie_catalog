import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_catalog/controller/session_controller.dart';
import 'package:movie_catalog/screen/login_screen.dart';
import 'package:movie_catalog/screen/profile_screen.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with AutomaticKeepAliveClientMixin {
  @override
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<SessionController>(
        builder: (controller) => Obx(() {
              return controller.currentUser.value == null
                  ? LoginScreen()
                  : ProfileScreen();
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
