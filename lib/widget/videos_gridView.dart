import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/ultils/functions/functions.dart';

import 'package:movie_catalog/widget/video_item.dart';

class VideoGridView extends StatelessWidget {
  final List<MovieVideoModel> videosList;
  const VideoGridView({
    Key? key,
    required this.videosList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Videos',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            TextButton(
                onPressed: _onShowDetailsPressed,
                child: Text(
                  'Detalhes',
                  style: TextStyle(
                      color: Get.theme.colorScheme.secondary, fontSize: 14),
                ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GridView.count(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: _crossAxisCount,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 16 / 9,
          children: List.generate(
              _videosLenth, (index) => VideoItem(video: videosList[index])),
        ),
      ],
    );
  }

  int get _maxLenth => _crossAxisCount * 3;
  bool get _showMore => videosList.length > _maxLenth;
  int get _videosLenth {
    return videosList.length > _maxLenth ? _maxLenth : videosList.length;
  }

  int get _crossAxisCount => getAxisCount(
      maxScreenWidth: MediaQuery.of(Get.context!).size.width,
      maxChildWidth: 160);

  void _onShowDetailsPressed() {}
}
