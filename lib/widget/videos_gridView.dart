import 'package:flutter/material.dart';
import 'package:movie_catalog/model/movie_video_model.dart';
import 'package:movie_catalog/widget/video_dialog.dart';

class VideosGridView extends StatefulWidget {
  Stream<List<MovieVideoModel>>? stream;
  List<MovieVideoModel>? initialData;

  VideosGridView(this.stream, this.initialData);

  @override
  _VideosGridViewState createState() => _VideosGridViewState();
}

class _VideosGridViewState extends State<VideosGridView> with TickerProviderStateMixin {
  bool _expandedGridView = false;

  Animation<double>? _arrowDownAnimation;

  AnimationController? _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowDownAnimation = Tween<double>(begin: 0, end: 0.5)
        .animate(CurvedAnimation(parent: _animationController!, curve: Curves.linearToEaseOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieVideoModel>>(
      stream: widget.stream,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        if (snapshot.data!.isEmpty) return Container();
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
              children: List.generate(
                  _expandedGridView
                      ? snapshot.data!.length
                      : snapshot.data!.length > 4
                          ? 4
                          : snapshot.data!.length, (index) {
                var videoItem = snapshot.data![index];
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
            if (snapshot.data!.length > 4)
              Center(
                  child: IconButton(
                onPressed: () {
                  setState(() {
                    _expandedGridView = !_expandedGridView;
                    if (_animationController!.isCompleted) {
                      _animationController!.reverse();
                    } else {
                      _animationController!.forward();
                    }
                  });
                },
                icon: RotationTransition(
                  turns: _arrowDownAnimation!,
                  child: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              )),
          ],
        );
      },
    );
  }
}
