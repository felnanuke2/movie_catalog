import 'package:flutter/material.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';

class SliverListTitles extends StatelessWidget {
  Stream<List<MovieItemModel>>? stream;
  List<MovieItemModel>? initialData;
  String? title;
  Future<List<MovieItemModel>> Function({bool? add})? addFunction;
  bool? tv;
  SliverListTitles(
      {required this.initialData,
      required this.stream,
      required this.title,
      required this.addFunction,
      this.tv});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: StreamBuilder<List<MovieItemModel>>(
      stream: stream!,
      initialData: initialData,
      builder: (
        context,
        snapshotMoviesList,
      ) {
        var movieList = snapshotMoviesList.data!;
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              height: 340,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == movieList.length)
                    return InkWell(
                      onTap: () => addFunction!(add: true),
                      child: AspectRatio(
                        aspectRatio: 9 / 18,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (index != 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ver Mais',
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            if (snapshotMoviesList.connectionState == ConnectionState.waiting)
                              Center(
                                child: CircularProgressIndicator(),
                              )
                          ],
                        )),
                      ),
                    );
                  return MovieItem(
                    movieList[index],
                    tv: tv,
                  );
                },
                itemCount: movieList.length + 1,
              ),
            ),
          ],
        );
      },
    ));
  }
}
