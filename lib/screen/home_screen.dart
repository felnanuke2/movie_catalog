import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/controller/home_screen_controller.dart';
import 'package:movie_catalog/model/movie_item_model.dart';
import 'package:movie_catalog/tabs/movie_tab.dart';
import 'package:movie_catalog/controller/profile_controller.dart';
import 'package:movie_catalog/tabs/profile_tab.dart';
import 'package:movie_catalog/tabs/tv_shows_tab.dart';
import 'package:movie_catalog/widget/bottom_navigatoion.dart';
import 'package:movie_catalog/ultils/home_search_delegate.dart';
import 'package:movie_catalog/widget/movie_item.dart';
import 'package:movie_catalog/ultils/sliver_app_bar_delegate.dart';
import 'package:movie_catalog/controller/user_controller.dart';
import 'package:movie_catalog/model/usermodel.dart';
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
    if (UserModel.instance.baseUser != null) {
      ProfileController.getMoviesWachList();
      ProfileController.getMoviesRated();
      ProfileController.getMoviesFavorites();
      ProfileController.getTvWachList();
      ProfileController.getTvRated();
      ProfileController.getTvFavorites();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MovieTvShowNavigationBar(
          currentPage: currentPage,
          pageController: _pageController,
        ),
        backgroundColor: BACKGROUND_COLOR.withOpacity(0.6),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [MovieTab(), TvShowsTab(), ProfileTab()],
        ));
  }
}
