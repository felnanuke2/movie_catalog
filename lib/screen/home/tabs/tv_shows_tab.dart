import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_catalog/controller/tv_controler.dart';
import 'package:movie_catalog/widget/persistent_header_search_bar.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';

class TvShowsTab extends StatefulWidget {
  @override
  _TvShowsTabState createState() => _TvShowsTabState();
}

class _TvShowsTabState extends State<TvShowsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<TvController>(
      init: TvController(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 35,
              ),
            ),
            PersistentHeaderSearchBar(SearchType.Tv),
            SliverListTitles(
              addFunction: controller.getPopularTvList,
              initialData: controller.popularList,
              stream: controller.popularList.stream,
              title: 'Séries Populares',
              tv: true,
            ),
            SliverListTitles(
              addFunction: controller.getLatestTvList,
              initialData: controller.latestTvList,
              stream: controller.latestTvList.stream,
              title: 'Ultimos Lançamentos',
              tv: true,
            ),
            SliverListTitles(
              addFunction: controller.getTopRatedTvList,
              initialData: controller.topratedTvList,
              stream: controller.topratedTvList.stream,
              title: 'Top Rated',
              tv: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
