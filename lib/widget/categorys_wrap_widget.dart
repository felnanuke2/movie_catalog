import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/movie_model_detailed.dart';

class CategorysWrapWidget extends StatelessWidget {
  List<Genres>? _categorysGengers;
  CategorysWrapWidget(this._categorysGengers);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: List.generate(
          _categorysGengers!.length,
          (index) => Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  _categorysGengers![index].name!,
                  style: TextStyle(color: Colors.white),
                ),
              )),
    );
  }
}
