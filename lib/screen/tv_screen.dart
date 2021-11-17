import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/constant/constant.dart';
import 'package:movie_catalog/controller/tv_screen_controller.dart';
import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/core/model/tv_model.dart';
import 'package:movie_catalog/widget/casting_grid_view.dart';
import 'package:movie_catalog/widget/categorys_wrap_widget.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';
import 'package:movie_catalog/widget/sliver_appBar_with_image.dart';
import 'package:movie_catalog/widget/stars_row_with_average.dart';
import 'package:movie_catalog/widget/user_rate_mark_fav_row.dart';
import 'package:movie_catalog/widget/videos_gridView.dart';

class TVScreen extends StatefulWidget {
  final MovieItemModel movieItemModel;
  const TVScreen({
    Key? key,
    required this.movieItemModel,
  }) : super(key: key);
  @override
  _TVScreenState createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: GetBuilder<TvScreenController>(
            init: TvScreenController(movieItemModel: widget.movieItemModel),
            builder: (controller) => CustomScrollView(
                  slivers: [
                    Obx(() => SliverAppbarWithImage(
                          image: controller.movieItemModel.posterPath!,
                          conenctAwait: controller.loadingData.value,
                        )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            _buildTitle(),
                            if (controller.currentUser != null)
                              UserRateMarkFavRow(
                                TV_MEDIA_TYPE,
                                widget.movieItemModel,
                                controller: Get.find(),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCategoryWidget(controller),
                            SizedBox(
                              height: 10,
                            ),
                            StarsRowWithAverage(
                                widget.movieItemModel.voteAverage!),
                            SizedBox(
                              height: 10,
                            ),
                            _buildSeasonsAndEpisodes(controller),
                            _buildDuration(controller),
                            _buildLaunchedAt(controller),
                            SizedBox(
                              height: 10,
                            ),
                            _buildOverViewContainer(controller),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCastingGridView(controller),
                            SizedBox(
                              height: 10,
                            ),
                            _buildVideosGrid(controller),
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
                    _buildSimilar(controller),
                  ],
                )));
  }

  Widget _buildVideosGrid(TvScreenController controller) {
    return FutureBuilder<List<MovieVideoModel>>(
      future: controller.movieVideos,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LinearProgressIndicator()
              : VideoGridView(videosList: snapshot.data!),
    );
  }

  Widget _buildSimilar(TvScreenController controller) {
    return FutureBuilder<List<MovieItemModel>>(
      builder: (context, snapshot) => SliverListTitles(
          initialData: [],
          stream: controller.getSimilarTvList(),
          title: 'Títulos Similares',
          addFunction: null),
    );
  }

  Widget _buildCastingGridView(TvScreenController controller) {
    return FutureBuilder<CreditModel>(
      future: controller.creditModel,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LinearProgressIndicator()
              : CastingGridView(
                  creditModel: snapshot.data!,
                ),
    );
  }

  Widget _buildLaunchedAt(TvScreenController controller) {
    return FutureBuilder<TvModel>(
        future: controller.tvModel,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? LinearProgressIndicator()
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Lançamento: ${snapshot.data!.firstAirDate}',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ));
  }

  Widget _buildDuration(TvScreenController controller) {
    return FutureBuilder<TvModel>(
      future: controller.tvModel,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LinearProgressIndicator()
              : Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Duração dos Episódios: ${snapshot.data!.episodeRunTime}m',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
    );
  }

  Widget _buildSeasonsAndEpisodes(TvScreenController controller) {
    return FutureBuilder<TvModel>(
      future: controller.tvModel,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LinearProgressIndicator()
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Temporadas: ${snapshot.data!.numberOfSeasons}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Episódios: ${snapshot.data!.numberOfEpisodes}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildCategoryWidget(TvScreenController controller) =>
      FutureBuilder<TvModel>(
        future: controller.tvModel,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? LinearProgressIndicator()
                : CategorysWrapWidget(snapshot.data?.genres),
      );

  InkWell _buildOverViewContainer(TvScreenController controller) {
    return InkWell(
      onTap: controller.expandeOverview,
      child: Center(
          child: Obx(() => Text(
                controller.movieItemModel.overview ?? '',
                maxLines: controller.expandedOverview.value ? null : 4,
                overflow: controller.expandedOverview.value
                    ? null
                    : TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 15),
              ))),
    );
  }

  Center _buildTitle() {
    return Center(
      child: Text(
        widget.movieItemModel.title!,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
