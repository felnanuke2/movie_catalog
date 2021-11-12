import 'package:flutter/material.dart';

import 'package:movie_catalog/core/model/movie_video_model.dart';
import 'package:movie_catalog/widget/video_dialog.dart';

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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Videos',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GridView.count(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 16 / 9,
          children: List.generate(videosList.length, (index) {
            var videoItem = videosList[index];
            var imageUr = 'https://img.youtube.com/vi/${videoItem.key}/0.jpg';
            return InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) => VideoDialog(videoItem.key),
              ),
              child: Hero(
                tag: videoItem.key!,
                child: Image.network(
                  imageUr,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),
        // if (snapshot.data!.length > 4)
        //   Center(
        //       child: IconButton(
        //     onPressed: () {
        //       setState(() {
        //         _expandedGridView = !_expandedGridView;
        //         if (_animationController!.isCompleted) {
        //           _animationController!.reverse();
        //         } else {
        //           _animationController!.forward();
        //         }
        //       });
        //     },
        //     icon: RotationTransition(
        //       turns: _arrowDownAnimation!,
        //       child: Icon(
        //         Icons.arrow_drop_down_outlined,
        //         color: Colors.white,
        //         size: 36,
        //       ),
        //     ),
        //   )),
      ],
    );
  }
}
