import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

class CounterProfileWidget extends StatelessWidget {
  List<MovieItemModel>? initialData;
  Stream<List<MovieItemModel>?>? stream;
  Stream<double>? animation;
  int? positionofPageView;
  String? title;
  CounterProfileWidget({
    required this.initialData,
    required this.stream,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieItemModel>?>(
        stream: stream,
        initialData: initialData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          var listCount = snapshot.data!.length;
          return Column(
            children: [
              Text(
                listCount.toString(),
              ),
              Text(
                title!,
              ),
            ],
          );
        });
  }
}
