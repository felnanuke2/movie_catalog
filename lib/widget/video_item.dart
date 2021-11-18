import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/widget/video_dialog.dart';

class VideoItem extends StatelessWidget {
  final MovieVideoModel video;
  const VideoItem({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => VideoDialog(video.key),
      ),
      child: Hero(
        tag: video.key!,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String get imageUrl => 'https://img.youtube.com/vi/${video.key}/0.jpg';
}
