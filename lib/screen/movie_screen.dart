import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/widget/casting_grid_view.dart';
import 'package:movie_catalog/widget/categorys_wrap_widget.dart';
import 'package:movie_catalog/controller/movie_controller.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';
import 'package:movie_catalog/widget/sliver_appBar_with_image.dart';
import 'package:movie_catalog/widget/stars_row_with_average.dart';
import 'package:movie_catalog/widget/user_rate_mark_fav_row.dart';
import 'package:movie_catalog/widget/videos_gridView.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen? _movieItemModel;
  UniqueKey? _uniqueKey;

  MovieScreen(this._movieItemModel, this._uniqueKey);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with TickerProviderStateMixin {
  var _movieControler = MovieScreenController();
  MovieModelDetail? _movieModelDetail;
  bool expandedOverview = false;
  final _meditype = 'movie';

  @override
  initState() {
    Future.delayed(Duration(milliseconds: 350)).then((value) =>
        _movieControler.getData(widget._movieItemModel!.id!.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieModelDetail>(
        stream: _movieControler.movieDetailStream,
        initialData: _movieControler.movieModelDetail,
        builder: (context, snapshot) {
          _movieModelDetail = snapshot.data;
          return Scaffold(
              backgroundColor: BACKGROUND_COLOR,
              body: CustomScrollView(
                slivers: [
                  SliverAppbarWithImage(
                      initialData1: _movieControler.listVideoModel,
                      initialData2: _movieControler.creditModel,
                      initialData3: _movieControler.movieModelDetail,
                      stream1: _movieControler.listVideosStream,
                      stream2: _movieControler.movieCreditStream,
                      stream3: _movieControler.movieDetailStream,
                      imagePath: widget._movieItemModel!.posterPath,
                      uniquekey: widget._uniqueKey!),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildTitle(),
                          if (UserModel.instance.baseUser != null)
                            UserRateMarkFavRow(
                                _meditype, widget._movieItemModel),
                          SizedBox(
                            height: 10,
                          ),
                          if (_movieModelDetail != null)
                            CategorysWrapWidget(
                                _movieControler.movieModelDetail!.genres),
                          SizedBox(
                            height: 10,
                          ),
                          StarsRowWithAverage(
                              widget._movieItemModel!.voteAverage!),
                          SizedBox(
                            height: 10,
                          ),
                          _buildMoviesDetail(),
                          _buildDirector(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: StreamBuilder<MovieModelDetail>(
                              initialData: _movieControler.movieModelDetail,
                              stream: _movieControler.movieDetailStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Container();

                                return Text(
                                  'Lançamento: ${snapshot.data!.releaseDate}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _buildOverViewContainer(),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Elenco',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CastingGridView(_movieControler.creditModel,
                              _movieControler.movieCreditStream),
                          SizedBox(
                            height: 10,
                          ),
                          VideosGridView(_movieControler.listVideosStream,
                              _movieControler.listVideoModel),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverListTitles(
                      initialData: _movieControler.recomendationsList,
                      stream: _movieControler.recomendationsStream,
                      title: 'Títulos Similares',
                      addFunction: null),
                ],
              ));
        });
  }

  Align _buildDirector() {
    return Align(
      alignment: Alignment.centerLeft,
      child: StreamBuilder<CreditModel>(
        stream: _movieControler.movieCreditStream,
        initialData: _movieControler.creditModel,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          var director = snapshot.data!.crew!
              .firstWhere((element) => element.job == 'Director')
              .name;
          return Text(
            'Diretor: $director',
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
        },
      ),
    );
  }

  StreamBuilder<MovieModelDetail> _buildMoviesDetail() {
    return StreamBuilder<MovieModelDetail>(
        stream: _movieControler.movieDetailStream,
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          _movieModelDetail = snapshot.data!;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_movieModelDetail!.runtime != null)
                    Expanded(
                      child: Text(
                        'Duração: ${_getTimeFormated(_movieModelDetail!.runtime!)}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Receita: \$ ${(_movieModelDetail!.revenue! / 1000000).round()} M',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Título Original: ${_movieModelDetail!.originalTitle}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          );
        });
  }

  String _getTimeFormated(int time) {
    var converted = time / 60;
    if (converted.toString().contains('.')) {
      var splitedTime = converted.toStringAsFixed(2).split('.');
      var hours = splitedTime[0];
      var minuts = ((num.parse(splitedTime[1]) / 100) * 60).round();
      return '${hours}h ${minuts}m';
    } else {
      return converted.toString() + 'h';
    }
  }

  Center _buildTitle() {
    return Center(
      child: Text(
        widget._movieItemModel!.title!,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  InkWell _buildOverViewContainer() {
    return InkWell(
      onTap: () {
        setState(() {
          expandedOverview = !expandedOverview;
        });
      },
      child: Center(
        child: Text(
          widget._movieItemModel!.overview!,
          maxLines: expandedOverview ? null : 4,
          overflow: expandedOverview ? null : TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
        ),
      ),
    );
  }
}
