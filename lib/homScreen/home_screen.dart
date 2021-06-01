import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/homScreen/controler/home_screen_controller.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/tabs/movie_tab.dart';
import 'package:movie_catalog/homScreen/tabs/tv_shows_tab.dart';
import 'package:movie_catalog/homScreen/widget/bottom_navigatoion.dart';
import 'package:movie_catalog/homScreen/widget/home_search_dlegate.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/homScreen/widget/sliver_app_bar_delegate.dart';
import 'package:movie_catalog/user/user_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  var _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            UserController.createSession();
          },
        ),
        bottomNavigationBar: MovieTvShowNavigationBar(
          currentPage: currentPage,
          pageController: _pageController,
        ),
        backgroundColor: BACKGROUND_COLOR.withOpacity(0.6),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [MovieTab(), TvShowsTab()],
        ));
  }
}
