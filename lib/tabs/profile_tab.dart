import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/controller/profile_controller.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/screens/login_screen.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/screens/profile_screen.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/user/base_user.dart';
import 'package:movie_catalog/user/usermodel.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with AutomaticKeepAliveClientMixin {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BaseUser?>(
        stream: UserModel.instance.baseUserController!.stream,
        initialData: UserModel.instance.baseUser,
        builder: (context, snapshot) {
          if (snapshot.data == null) return LoginScreen();
          var user = snapshot.data!;

          return ProfileScreen(user);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
