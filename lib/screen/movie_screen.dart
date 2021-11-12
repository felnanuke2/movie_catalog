import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/controller/movie_screen_controller.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
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
        init: MovieScreenController(),
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
                              controller.meditype, widget._movieItemModel),
                        SizedBox(
                          height: 10,
                        ),
                        if (controller.movieModelDetail.value != null)
                          CategorysWrapWidget(
                              controller.movieModelDetail.value!.genres),
                        SizedBox(
                          height: 10,
                        ),
                        StarsRowWithAverage(
                            widget._movieItemModel!.voteAverage!),
                        SizedBox(
                          height: 10,
                        ),
                        _buildMoviesDetail(controller),
                        _buildDirector(controller),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Obx(() => Text(
                                  'Lançamento: ${controller.movieModelDetail.value?.releaseDate ?? ''}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        _buildOverViewContainer(controller),
                        SizedBox(
                          height: 10,
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
                        Obx(() => controller.creditModel.value != null
                            ? CastingGridView(
                                creditModel: controller.creditModel.value!,
                              )
                            : SizedBox.shrink()),
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

  Align _buildDirector(MovieScreenController controller) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Obx(() {
        if (controller.creditModel.value?.crew == null)
          return SizedBox.shrink();
        return Text(
          'Diretor: ${controller.director}}',
          style: TextStyle(color: Colors.white, fontSize: 16),
        );
      }),
    );
  }

  Widget _buildMoviesDetail(MovieScreenController controller) {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.movieModelDetail.value!.runtime != null)
                  Expanded(
                    child: Text(
                      'Duração: ${_getTimeFormated(controller.movieModelDetail.value!.runtime!)}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Receita: \$ ${(controller.movieModelDetail.value!.revenue! / 1000000).round()} M',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Título Original: ${controller.movieModelDetail.value!.originalTitle}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ));
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
