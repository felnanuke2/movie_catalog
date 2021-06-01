import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/homScreen/controler/home_screen_controller.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/widget/home_search_dlegate.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/homScreen/widget/persistent_header_search_bar.dart';
import 'package:movie_catalog/homScreen/widget/sliverListTitles.dart';
import 'package:movie_catalog/homScreen/widget/sliver_app_bar_delegate.dart';

class MovieTab extends StatefulWidget {
  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> with AutomaticKeepAliveClientMixin<MovieTab> {
  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() async {
    await HomeScreenController.getPopularMovies();
    await HomeScreenController.getUpcomingMovies();
    await HomeScreenController.getPlayNowMovies();
    await HomeScreenController.getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 45,
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              title: Text(
                'Olá Visitante',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                'Escolha seus Filmes e Séries Favoritos',
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              trailing: Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: FlutterLogo(),
                ),
              ),
            ),
          ),
          PersistentHeaderSearchBar(),
          SliverListTitles(
              initialData: HomeScreenController.popularMovies,
              stream: HomeScreenController.popularMoviesStream,
              title: 'Filmes Populares',
              addFunction: HomeScreenController.getPopularMovies),
          SliverListTitles(
              initialData: HomeScreenController.upcomingMovies,
              stream: HomeScreenController.upcomingMoviesStream,
              title: 'Em Breve',
              addFunction: HomeScreenController.getUpcomingMovies),
          SliverListTitles(
              initialData: HomeScreenController.playnowMovies,
              stream: HomeScreenController.playNowMoviesStream,
              title: 'Nos Cinemas',
              addFunction: HomeScreenController.getPlayNowMovies),
          SliverListTitles(
              initialData: HomeScreenController.topRatedMovies,
              stream: HomeScreenController.topRatedMoviesStream,
              title: 'Top Rated',
              addFunction: HomeScreenController.getTopRated),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
