import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_catalog/constant/constant.dart';
import 'package:movie_catalog/controller/session_controller.dart';
import 'package:movie_catalog/screen/home/tabs/movie_tab.dart';
import 'package:movie_catalog/screen/home/tabs/profile_tab.dart';
import 'package:movie_catalog/screen/home/tabs/tv_shows_tab.dart';
import 'package:movie_catalog/widget/bottom_navigatoion.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  var _pageController = PageController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionController>(
      init: SessionController(),
      builder: (controller) => Scaffold(
          bottomNavigationBar: MovieTvShowNavigationBar(
            currentPage: currentPage,
            pageController: _pageController,
          ),
          backgroundColor: BACKGROUND_COLOR.withOpacity(0.6),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [MovieTab(), TvShowsTab(), ProfileTab()],
          )),
    );
  }
}
