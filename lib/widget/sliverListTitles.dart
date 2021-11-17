import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/widget/animated_arrow_scroll_widget.dart';
import 'package:movie_catalog/widget/movie_item.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:get/state_manager.dart';

class SliverListTitles extends StatefulWidget {
  SliverListTitles(
      {required this.initialData,
      required this.stream,
      required this.title,
      required this.addFunction,
      this.tv});

  Stream<List<MovieItemModel>?>? stream;
  List<MovieItemModel>? initialData;
  String? title;
  Future<List<MovieItemModel>> Function({bool? add})? addFunction;
  bool? tv;

  @override
  State<SliverListTitles> createState() => _SliverListTitlesState();
}

class _SliverListTitlesState extends State<SliverListTitles> {
  final _scrolController = ScrollController();
  final isArrowScrollVisible = false.obs;
  bool isLoagind = false;
  @override
  void initState() {
    _scrolController.addListener(_scrollListner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Stack(
      children: [
        StreamBuilder<List<MovieItemModel>?>(
          stream: widget.stream,
          initialData: widget.initialData,
          builder: (
            context,
            snapshotMoviesList,
          ) {
            final movieList = snapshotMoviesList.data!;
            return Column(
              children: [
                _buildName(),
                _buildListView(movieList),
              ],
            );
          },
        ),
        _buildScrolButton()
      ],
    ));
  }

  Positioned _buildScrolButton() {
    return Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        child: AnimatedArrowScrollWidget(
          scrollToStart: _scrollToStart,
          key: UniqueKey(),
          isExpandedStream: isArrowScrollVisible.stream,
        ));
  }

  Container _buildName() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        title: Text(
          widget.title!,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Container _buildListView(List<MovieItemModel> movieList) {
    return Container(
      height: 340,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        controller: _scrolController,
        itemCount: widget.addFunction != null
            ? movieList.length + 1
            : movieList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == movieList.length && widget.addFunction != null)
            return _buildLoadingMore(index);
          return MovieItem(
            movieList[index],
            tv: widget.tv,
          );
        },
      ),
    );
  }

  Widget _buildLoadingMore(int index) {
    return AspectRatio(
      aspectRatio: 9 / 18,
      child: VisibilityDetector(
        key: UniqueKey(),
        onVisibilityChanged: _onVisibilityChange,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        )),
      ),
    );
  }

  void _onVisibilityChange(VisibilityInfo info) async {
    if (isLoagind) return;
    isLoagind = true;
    await widget.addFunction!();
    isLoagind = false;
  }

  void _scrollListner() {
    final position = _scrolController.position.pixels;
    isArrowScrollVisible.value = position > 500;
  }

  void _scrollToStart() {
    _scrolController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
