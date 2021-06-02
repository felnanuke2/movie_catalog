import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_catalog/homScreen/controler/home_screen_controller.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/homScreen/widget/persistent_header_search_bar.dart';
import 'package:movie_catalog/homScreen/widget/sliverListTitles.dart';

class TvShowsTab extends StatefulWidget {
  @override
  _TvShowsTabState createState() => _TvShowsTabState();
}

class _TvShowsTabState extends State<TvShowsTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    _setData();
    super.initState();
  }

  _setData() async {
    await HomeScreenController.getPopularTvshows();
    await HomeScreenController.getLatestTvshows();
    await HomeScreenController.getTopRatedTvshows();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 35,
            ),
          ),
          PersistentHeaderSearchBar(),
          SliverListTitles(
            addFunction: HomeScreenController.getPopularTvshows,
            initialData: HomeScreenController.popularTvList,
            stream: HomeScreenController.popularTvStream,
            title: 'Séries Populares',
            tv: true,
          ),
          SliverListTitles(
            addFunction: HomeScreenController.getLatestTvshows,
            initialData: HomeScreenController.ontheAirTvList,
            stream: HomeScreenController.latesTvStream,
            title: 'Ultimos Lançamentos',
            tv: true,
          ),
          SliverListTitles(
            addFunction: HomeScreenController.getTopRatedTvshows,
            initialData: HomeScreenController.topRatedTvList,
            stream: HomeScreenController.topRatedTvStream,
            title: 'Top Rated',
            tv: true,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
