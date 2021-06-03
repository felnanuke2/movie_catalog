import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_catalog/controller/home_screen_controller.dart';
import 'package:movie_catalog/widget/persistent_header_search_bar.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';
import 'package:movie_catalog/model/base_user.dart';
import 'package:movie_catalog/model/usermodel.dart';

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
            child: StreamBuilder<BaseUser?>(
                stream: UserModel.instance.baseUserController!.stream,
                initialData: UserModel.instance.baseUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListTile(
                      title: Text(
                        'Olá ${snapshot.data!.userName}',
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
                          child: snapshot.data!.avatar != null
                              ? Image.network(snapshot.data!.avatar!)
                              : FlutterLogo(),
                        ),
                      ),
                    );
                  return ListTile(
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
                  );
                }),
          ),
          PersistentHeaderSearchBar(SearchType.Movie),
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
  bool get wantKeepAlive => true;
}
