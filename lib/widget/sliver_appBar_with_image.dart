import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/credit_model.dart';

class SliverAppbarWithImage extends StatelessWidget {
  Stream<List>? stream1;
  List? initialData1;
  Stream<CreditModel>? stream2;
  CreditModel? initialData2;
  Stream? stream3;
  dynamic initialData3;
  String? imagePath;

  SliverAppbarWithImage(
      {required this.initialData1,
      required this.initialData2,
      required this.initialData3,
      required this.stream1,
      required this.stream2,
      required this.stream3,
      required this.imagePath,
      required this.uniquekey});

  var uniquekey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: stream1,
        initialData: initialData1,
        builder: (context, snapshot1) {
          return StreamBuilder<CreditModel>(
              stream: stream2,
              initialData: initialData2,
              builder: (context, snapshot2) {
                return StreamBuilder(
                    stream: stream3,
                    initialData: initialData3,
                    builder: (context, snapshot3) {
                      bool conenctAwait = snapshot1.data!.isEmpty &&
                          snapshot2.data == null &&
                          snapshot3.data == null;

                      return SliverAppBar(
                        expandedHeight:
                            (MediaQuery.of(context).size.width / 2) * 3,
                        backgroundColor: Colors.transparent,
                        pinned: true,
                        flexibleSpace: Hero(
                          tag: uniquekey,
                          child: AspectRatio(
                            aspectRatio: 2 / 3.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://www.themoviedb.org/t/p/w600_and_h900_bestv2$imagePath',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          if (conenctAwait)
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      );
                    });
              });
        });
  }
}
