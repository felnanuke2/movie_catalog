import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/model/movie_item_model.dart';
import 'package:movie_catalog/controller/profile_controller.dart';
import 'package:movie_catalog/widget/casting_grid_view.dart';
import 'package:movie_catalog/widget/categorys_wrap_widget.dart';
import 'package:movie_catalog/controller/tv_tab_controler.dart';
import 'package:movie_catalog/model/tv_model.dart';
import 'package:movie_catalog/controller/user_controller.dart';
import 'package:movie_catalog/model/usermodel.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';
import 'package:movie_catalog/widget/sliver_appBar_with_image.dart';
import 'package:movie_catalog/widget/stars_gesture_rate_widget.dart';
import 'package:movie_catalog/widget/stars_row_with_average.dart';
import 'package:movie_catalog/widget/user_rate_mark_fav_row.dart';
import 'package:movie_catalog/widget/videos_gridView.dart';
import 'package:rive/rive.dart' as rive;

class TVScreen extends StatefulWidget {
  MovieItemModel? movieItemModel;
  UniqueKey? _uniqueKey;
  TVScreen(this.movieItemModel, this._uniqueKey);

  @override
  _TVScreenState createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> with TickerProviderStateMixin {
  var initiated = false;
  var _controller = TvTabController();
  TvModel? tvModel;
  bool expandedOverview = false;
  bool expandVideoGrid = false;

  bool isLiked = false;
  bool wachList = false;
  bool rated = false;
  final _meditype = 'tv';

  @override
  void initState() {
    super.initState();
    _controller.getData(widget.movieItemModel!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: StreamBuilder<TvModel>(
          stream: _controller.tvStream,
          initialData: _controller.tvModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              tvModel = snapshot.data;
            }
            return CustomScrollView(
              slivers: [
                SliverAppbarWithImage(
                  initialData1: _controller.similarTVList,
                  initialData2: _controller.creditModel,
                  initialData3: _controller.tvModel,
                  stream1: _controller.similarListStream,
                  stream2: _controller.creditStream,
                  stream3: _controller.tvStream,
                  imagePath: widget.movieItemModel!.posterPath,
                  uniquekey: widget._uniqueKey!,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        _buildTitle(),
                        if (UserModel.instance.baseUser != null)
                          UserRateMarkFavRow(_meditype, widget.movieItemModel),
                        SizedBox(
                          height: 10,
                        ),
                        if (tvModel != null)
                          CategorysWrapWidget(tvModel!.genres),
                        SizedBox(
                          height: 10,
                        ),
                        StarsRowWithAverage(
                            widget.movieItemModel!.voteAverage!),
                        SizedBox(
                          height: 10,
                        ),
                        if (tvModel != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Temporadas: ${tvModel!.numberOfSeasons}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Episódios: ${tvModel!.numberOfEpisodes}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (tvModel != null)
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Duração dos Episódios: ${tvModel!.episodeRunTime}m',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        if (tvModel != null)
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Lançamento: ${tvModel!.firstAirDate}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildOverViewContainer(),
                        SizedBox(
                          height: 10,
                        ),
                        CastingGridView(
                            _controller.creditModel, _controller.creditStream),
                        SizedBox(
                          height: 10,
                        ),
                        VideosGridView(
                            _controller.videosStream, _controller.videoList),
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
                    initialData: _controller.similarTVList,
                    stream: _controller.similarListStream,
                    title: 'Títulos Similares',
                    addFunction: null),
              ],
            );
          }),
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
          widget.movieItemModel!.overview!,
          maxLines: expandedOverview ? null : 4,
          overflow: expandedOverview ? null : TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
        ),
      ),
    );
  }

  Center _buildTitle() {
    return Center(
      child: Text(
        widget.movieItemModel!.title!,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
