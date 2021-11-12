import 'package:flutter/material.dart';

class SliverAppbarWithImage extends StatelessWidget {
  final bool conenctAwait;
  final String image;
  SliverAppbarWithImage({
    Key? key,
    required this.conenctAwait,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: (MediaQuery.of(context).size.width / 2) * 3,
      backgroundColor: Colors.transparent,
      pinned: true,
      flexibleSpace: Hero(
        tag: image,
        child: AspectRatio(
          aspectRatio: 2 / 3.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://www.themoviedb.org/t/p/w600_and_h900_bestv2$image',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      actions: [
        if (conenctAwait)
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
