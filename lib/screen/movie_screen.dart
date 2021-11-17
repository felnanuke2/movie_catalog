import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/constant/constant.dart';
import 'package:movie_catalog/controller/movie_screen_controller.dart';
import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';
import 'package:movie_catalog/widget/casting_grid_view.dart';
import 'package:movie_catalog/widget/categorys_wrap_widget.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';
import 'package:movie_catalog/widget/sliver_appBar_with_image.dart';
import 'package:movie_catalog/widget/stars_row_with_average.dart';
import 'package:movie_catalog/widget/user_rate_mark_fav_row.dart';
import 'package:movie_catalog/widget/videos_gridView.dart';

class MovieScreen extends StatefulWidget {
  MovieItemModel? _movieItemModel;
  MovieScreen(this._movieItemModel);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieScreenController>(
        init: MovieScreenController(widget._movieItemModel!),
        builder: (controller) => Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            body: CustomScrollView(
              slivers: [
                Obx(() => SliverAppbarWithImage(
                      conenctAwait: controller.awaiting.value,
                      image: widget._movieItemModel?.posterPath ?? '',
                    )),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTitle(),
                        if (controller.isAuthenticated)
                          UserRateMarkFavRow(
                            controller.meditype,
                            widget._movieItemModel,
                            controller: Get.find(),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildMoviesDetail(controller),
                        SizedBox(
                          height: 10,
                        ),
                        _buildOverViewContainer(controller),
                        SizedBox(
                          height: 10,
                        ),
                        _buildCredits(controller),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => controller.videosList.isEmpty
                            ? SizedBox.shrink()
                            : VideoGridView(videosList: controller.videosList)),
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
                    initialData: controller.recomendationsList,
                    stream: controller.recomendationsList.stream,
                    title: 'Títulos Similares',
                    addFunction: null),
              ],
            )));
  }

  Widget _buildCredits(MovieScreenController controller) {
    return FutureBuilder<CreditModel>(
      future: controller.creditModel,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LinearProgressIndicator()
              : Column(
                  children: [
                    _buildDirector(
                      snapshot.data!,
                      controller,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elenco',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CastingGridView(
                      creditModel: snapshot.data!,
                    ),
                  ],
                ),
    );
  }

  Align _buildDirector(
      CreditModel creditModel, MovieScreenController controller) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Diretor: ${controller.getDirector(creditModel)}}',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildMoviesDetail(MovieScreenController controller) {
    return FutureBuilder<MovieModelDetail>(
      future: controller.movieModelDetail,
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? LinearProgressIndicator()
          : Column(
              children: [
                Column(
                  children: [
                    if (snapshot.data != null)
                      CategorysWrapWidget(snapshot.data?.genres),
                    SizedBox(
                      height: 10,
                    ),
                    StarsRowWithAverage(
                        widget._movieItemModel?.voteAverage ?? 0),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (snapshot.data?.runtime != null)
                      Expanded(
                        child: Text(
                          'Duração: ${_getTimeFormated(snapshot.data?.runtime ?? 0)}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Receita: \$ ${((snapshot.data?.revenue ?? 0) / 1000000).round()} M',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Título Original: ${snapshot.data?.originalTitle ?? ''}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lançamento: ${snapshot.data?.releaseDate ?? ''}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ],
            ),
    );
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

  Widget _buildOverViewContainer(MovieScreenController controller) {
    return Obx(() => InkWell(
          onTap: controller.toggleOverView,
          child: Center(
            child: Text(
              widget._movieItemModel!.overview!,
              maxLines: controller.expandedOverview.value ? null : 4,
              overflow: controller.expandedOverview.value
                  ? null
                  : TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
            ),
          ),
        ));
  }
}
