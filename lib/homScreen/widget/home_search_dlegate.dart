import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/homScreen/controler/home_screen_controller.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';

class HomeSearch extends SearchDelegate {
  List<MovieItemModel> movieList = HomeScreenController.popularMovies;
  var _homeCntroler = HomeScreenController();
  var _lastQuery = '';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
      inputDecorationTheme:
          InputDecorationTheme(hintStyle: TextStyle(color: Colors.white.withOpacity(0.4))),
    );
  }

  @override
  String get searchFieldLabel => "Pesquisar";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: _homeCntroler.searchStremResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Container(width: 20, height: 20, child: CircularProgressIndicator()),
            );
          return Container();
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pop(context),
        child: RotationTransition(turns: super.transitionAnimation, child: Icon(Icons.arrow_back)));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future.delayed(Duration(seconds: 1, milliseconds: 200))
        .then((value) => _homeCntroler.queryStream = super.query);

    return StreamBuilder<List<MovieItemModel>>(
      stream: _homeCntroler.searchStremResult,
      initialData: HomeScreenController.searchMoviesStorage,
      builder: (context, snapshot) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var movieItem = snapshot.data![index];
                  var url = movieItem.posterPath;
                  if (url != null) {
                    url = 'https://www.themoviedb.org/t/p/w200' + url;
                  } else {
                    url = null;
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white.withOpacity(0.04),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          child: AspectRatio(
                            aspectRatio: 0.699,
                            child: url != null
                                ? Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                  )
                                : FlutterLogo(),
                          ),
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(8), child: Text(movieItem.title!)))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars(MovieItemModel _movieItemModel) {
    String _voteAvagare = (_movieItemModel.voteAverage! / 2).toString();
    int _voteRate = 0;
    int? _voteRateRest;
    if (_voteAvagare.toString().contains('.')) {
      var splitedAverage = _voteAvagare.split('.');
      _voteRate = int.parse(splitedAverage[0]);
      _voteRateRest = num.parse(splitedAverage[1]).round();
    } else {
      _voteRate = int.parse(_voteAvagare);
    }
    if (_voteRateRest != null) {
      _voteRate += 1;
    }

    return List.generate(_voteRate, (index) {
      if (_voteRateRest != null) {
        if (index == _voteRate - 1) return Icon(Icons.star_half_outlined, color: Colors.amber);
      }
      return Icon(Icons.star, color: Colors.amber);
    });
  }

  ListView _buildResult() {
    if (HomeScreenController.searchMoviesStorage.isNotEmpty) {
      this.movieList = HomeScreenController.searchMoviesStorage;
    }
    return ListView.builder(
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        var movieItem = movieList[index];
        return Container(
          color: Colors.white.withOpacity(0.02),
          margin: EdgeInsets.symmetric(vertical: 8),
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 0.699,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: movieItem.posterPath != null
                      ? Image.network(
                          'https://www.themoviedb.org/t/p/w400' + movieItem.posterPath!,
                          fit: BoxFit.cover,
                        )
                      : FlutterLogo(),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            movieItem.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          ),
                          if (movieItem.overview != null)
                            Text(
                              movieItem.overview!,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Stack(
                      children: [
                        Row(
                          children: List<Widget>.generate(5,
                                  (index) => Icon(Icons.star_border_outlined, color: Colors.grey)) +
                              [Text('  ${movieItem.voteAverage}')],
                        ),
                        Row(
                          children: _buildStars(movieItem),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
