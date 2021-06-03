import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_catalog/model/movie_item_model.dart';
import 'package:movie_catalog/screen/movie_screen.dart';
import 'package:movie_catalog/screen/tv_screen.dart';

class MovieItem extends StatelessWidget {
  MovieItemModel? _movieItemModel;
  var _uniqueKey = UniqueKey();
  MovieItem(this._movieItemModel, {this.tv});
  bool? tv;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          if (tv == true) return TVScreen(_movieItemModel, _uniqueKey);
          return MovieScreen(_movieItemModel, _uniqueKey);
        },
      )),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: AspectRatio(
          aspectRatio: 9 / 18,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: _uniqueKey,
                    child: Image.network(
                      'https://www.themoviedb.org/t/p/w500${_movieItemModel!.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  _movieItemModel!.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                subtitle: Stack(
                  children: [
                    Row(
                      children: List.generate(
                          5, (index) => Icon(Icons.star_border_outlined, color: Colors.grey)),
                    ),
                    Row(
                      children: _buildStars(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStars() {
    String _voteAvagare = (_movieItemModel!.voteAverage! / 2).toString();
    int _voteRate = 0;
    int? _voteRateRest;
    if (_voteAvagare.toString().contains('.')) {
      var splitedAverage = _voteAvagare.split('.');
      _voteRate = int.parse(splitedAverage[0]);
      _voteRateRest = num.parse(splitedAverage[1]).round();
    } else {
      _voteRate = int.parse(_voteAvagare);
    }
    if (_voteRateRest != null) {
      _voteRate += 1;
    }

    return List.generate(_voteRate, (index) {
      if (_voteRateRest != null) {
        if (index == _voteRate - 1) return Icon(Icons.star_half_outlined, color: Colors.amber);
      }
      return Icon(Icons.star, color: Colors.amber);
    });
  }
}
