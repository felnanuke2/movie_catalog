import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;
import 'package:movie_catalog/constant/constant.dart';
import 'package:movie_catalog/controller/session_controller.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/widget/stars_gesture_rate_widget.dart';

class UserRateMarkFavRow extends StatefulWidget {
  final SessionController controller;
  String? _mediaType;
  MovieItemModel? _movieItemModel;

  UserRateMarkFavRow(
    this._mediaType,
    this._movieItemModel, {
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  _UserRateMarkFavRowState createState() => _UserRateMarkFavRowState();
}

class _UserRateMarkFavRowState extends State<UserRateMarkFavRow> {
  rive.Artboard? _riveArtBoard;
  bool wachList = false;
  bool rated = false;
  bool? isLiked;
  num starCount = 0.5;
  late SessionController controller;

  @override
  void initState() {
    controller = widget.controller;
    rootBundle.load('assets/favorite Button.riv').then((value) {
      final file = rive.RiveFile.import(value);
      final artB = file.mainArtboard;
      _riveArtBoard = artB;
      setState(() {
        _riveArtBoard!
            .addController(rive.SimpleAnimation(!isLiked! ? 'unlike' : 'like'));
      });
    });

    if (controller.currentUser.value != null) {
      if (widget._mediaType == 'tv') {
        isLiked = controller.tvFavorites
            .map((e) => e.query)
            .toList()
            .contains(widget._movieItemModel!.query!);
        wachList = controller.tvWhactList
            .map((e) => e.query)
            .toList()
            .contains(widget._movieItemModel!.query!);
        rated = controller.tvRated
            .map((e) => e.query)
            .toList()
            .contains(widget._movieItemModel!.query!);
        if (rated) {
          var item = controller.tvRated.firstWhere(
              (element) => element.query == widget._movieItemModel!.query!);
          starCount = item.rating!;
        }
      } else {
        isLiked = controller.movieFavorites
            .map((e) => e.query)
            .toList()
            .contains(widget._movieItemModel!.query!);
        wachList = controller.movieWhactList
            .map((e) => e.query)
            .toList()
            .contains(widget._movieItemModel!.query!);
        rated = controller.movieRated
            .map((e) => e.query)
            .toList()
            .contains(widget._movieItemModel!.query!);
        if (rated) {
          var item = controller.movieRated.firstWhere(
              (element) => element.query == widget._movieItemModel!.query!);
          starCount = item.rating!;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () {
              _riveArtBoard!.addController(
                  rive.SimpleAnimation(isLiked! ? 'unlike' : 'like'));
              isLiked = !isLiked!;
              controller.markAsFavorite(
                  isLiked!, widget._mediaType!, widget._movieItemModel!);
            },
            child: _riveArtBoard != null
                ? rive.Rive(artboard: _riveArtBoard!)
                : Icon(
                    Icons.favorite,
                    color: Color(0xffef47b6),
                  ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: wachList ? ConstantColors.background : Colors.white,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                wachList = !wachList;
                controller.addToWatchList(
                    wachList, widget._mediaType!, widget._movieItemModel!);
              });
            },
            child: Icon(
              Icons.bookmark,
              color: wachList ? Colors.red : ConstantColors.background,
              size: 28,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: rated ? ConstantColors.background : Colors.white,
          ),
          child: InkWell(
            onTap: () {
              _starRateGesture(context);
            },
            child: Icon(
              Icons.star,
              color: rated ? Colors.amber : ConstantColors.background,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  _starRateGesture(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) => StarsGestureRateWidget(starCount),
    );
    if (result != null) {
      setState(() {
        rated = true;
        starCount = result;
        if (widget._mediaType == 'tv') {
          controller.rateSerie(
              widget._movieItemModel!, num.parse(result.toStringAsFixed(1)));
        } else {
          controller.rateMovie(
              widget._movieItemModel!, num.parse(result.toStringAsFixed(1)));
        }
      });
    }
  }
}
