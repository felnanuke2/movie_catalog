import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

import 'package:rive/rive.dart' as rive;
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/controller/profile_controller.dart';
import 'package:movie_catalog/controller/user_controller.dart';
import 'package:movie_catalog/widget/stars_gesture_rate_widget.dart';

class UserRateMarkFavRow extends StatefulWidget {
  String? _mediaType;
  MovieItemModel? _movieItemModel;
  UserRateMarkFavRow(
    this._mediaType,
    this._movieItemModel,
  );

  @override
  _UserRateMarkFavRowState createState() => _UserRateMarkFavRowState();
}

class _UserRateMarkFavRowState extends State<UserRateMarkFavRow> {
  rive.Artboard? _riveArtBoard;
  bool wachList = false;
  bool rated = false;
  bool? isLiked;
  num starCount = 0.5;

  @override
  void initState() {
    rootBundle.load('assets/favorite Button.riv').then((value) {
      final file = rive.RiveFile.import(value);
      final artB = file.mainArtboard;
      _riveArtBoard = artB;
      setState(() {
        _riveArtBoard!
            .addController(rive.SimpleAnimation(!isLiked! ? 'unlike' : 'like'));
      });
    });

    if (UserModel.instance.baseUser != null) {
      if (widget._mediaType == 'tv') {
        isLiked = ProfileController.tvFavorites
            .map((e) => e.id)
            .toList()
            .contains(widget._movieItemModel!.id!);
        wachList = ProfileController.tvWhactList
            .map((e) => e.id)
            .toList()
            .contains(widget._movieItemModel!.id!);
        rated = ProfileController.tvRated
            .map((e) => e.id)
            .toList()
            .contains(widget._movieItemModel!.id!);
        if (rated) {
          var item = ProfileController.tvRated.firstWhere(
              (element) => element.id == widget._movieItemModel!.id!);
          starCount = item.rating!;
        }
      } else {
        isLiked = ProfileController.movieFavorites
            .map((e) => e.id)
            .toList()
            .contains(widget._movieItemModel!.id!);
        wachList = ProfileController.movieWhactList
            .map((e) => e.id)
            .toList()
            .contains(widget._movieItemModel!.id!);
        rated = ProfileController.movieRated
            .map((e) => e.id)
            .toList()
            .contains(widget._movieItemModel!.id!);
        if (rated) {
          var item = ProfileController.movieRated.firstWhere(
              (element) => element.id == widget._movieItemModel!.id!);
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
            color: BACKGROUND_COLOR,
          ),
          child: InkWell(
            onTap: () {
              _riveArtBoard!.addController(
                  rive.SimpleAnimation(isLiked! ? 'unlike' : 'like'));
              isLiked = !isLiked!;
              UserController.markAsFavorite(
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
            color: wachList ? BACKGROUND_COLOR : Colors.white,
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                wachList = !wachList;
                UserController.addToWatchList(
                    wachList, widget._mediaType!, widget._movieItemModel!);
              });
            },
            child: Icon(
              Icons.bookmark,
              color: wachList ? Colors.red : BACKGROUND_COLOR,
              size: 28,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: rated ? BACKGROUND_COLOR : Colors.white,
          ),
          child: InkWell(
            onTap: () {
              _starRateGesture(context);
            },
            child: Icon(
              Icons.star,
              color: rated ? Colors.amber : BACKGROUND_COLOR,
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
          UserController.rateSerie(
              widget._movieItemModel!, num.parse(result.toStringAsFixed(1)));
        } else {
          UserController.rateMovie(
              widget._movieItemModel!, num.parse(result.toStringAsFixed(1)));
        }
      });
    }
  }
}
