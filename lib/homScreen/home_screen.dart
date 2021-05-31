import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/homScreen/controler/home_screen_controller.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/widget/home_search_dlegate.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/homScreen/widget/sliver_app_bar_delegate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeScreenController.getPopularMovies();
    HomeScreenController.getUpcomingMovies();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR.withOpacity(0.6),
        body: Padding(
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
              _buildSearchPersistent(context),
              _buildPopularMovies(),
              _buildUpcomingMovies()
            ],
          ),
        ));
  }

  SliverToBoxAdapter _buildUpcomingMovies() {
    return SliverToBoxAdapter(
        child: StreamBuilder<List<MovieItemModel>>(
      stream: HomeScreenController.upcomingMoviesStream,
      initialData: HomeScreenController.upcomingMovies,
      builder: (
        context,
        snapshotMoviesList,
      ) {
        var movieList = snapshotMoviesList.data!;
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(
                  'Próximos Lançamentos',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              height: 340,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == movieList.length)
                    return InkWell(
                      onTap: () => HomeScreenController.getUpcomingMovies(add: true),
                      child: AspectRatio(
                        aspectRatio: 9 / 18,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ver Mais',
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            if (snapshotMoviesList.connectionState == ConnectionState.waiting)
                              Center(
                                child: CircularProgressIndicator(),
                              )
                          ],
                        )),
                      ),
                    );
                  return MovieItem(movieList[index]);
                },
                itemCount: movieList.length + 1,
              ),
            ),
          ],
        );
      },
    ));
  }

  SliverPersistentHeader _buildSearchPersistent(BuildContext context) {
    return SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 105,
          maxHeight: 105,
          child: TextField(
            onTap: () {
              showSearch(context: context, delegate: HomeSearch());
            },
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              fillColor: BACKGROUND_COLOR,
              hintText: 'Pesquisar',
            ),
          ),
        ));
  }

  SliverToBoxAdapter _buildPopularMovies() {
    return SliverToBoxAdapter(
        child: StreamBuilder<List<MovieItemModel>>(
      initialData: HomeScreenController.popularMovies,
      stream: HomeScreenController.popularMoviesStream,
      builder: (
        context,
        snapshotMoviesList,
      ) {
        var movieList = snapshotMoviesList.data!;
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(
                  'Filmes Populares',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              height: 340,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == movieList.length)
                    return InkWell(
                      onTap: () => HomeScreenController.getPopularMovies(add: true),
                      child: AspectRatio(
                        aspectRatio: 9 / 18,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ver Mais',
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            if (snapshotMoviesList.connectionState == ConnectionState.waiting)
                              Center(
                                child: CircularProgressIndicator(),
                              )
                          ],
                        )),
                      ),
                    );
                  return MovieItem(movieList[index]);
                },
                itemCount: movieList.length + 1,
              ),
            ),
          ],
        );
      },
    ));
  }
}
