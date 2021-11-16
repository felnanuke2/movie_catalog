import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';
import 'package:movie_catalog/widget/movie_item.dart';

class GridUserProfile extends StatelessWidget {
  Stream<List<MovieItemModel>?> stream;
  List<MovieItemModel>? initialdata;
  bool? tv;
  void Function({bool? add})? addFun;
  GridUserProfile(
      {required this.addFun,
      required this.initialdata,
      required this.stream,
      this.tv});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieItemModel>?>(
        stream: stream,
        initialData: initialdata,
        builder: (context, snapshot) {
          return GridView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.7 / 3),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => MovieItem(
              snapshot.data![index],
              tv: tv,
            ),
          );
        });
  }
}
