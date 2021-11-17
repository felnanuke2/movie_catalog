import 'package:flutter/material.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      elevation: 0,
      floating: true,
      snap: true,
      title: Text('Movie Catalog', style: TextStyle(color: Colors.white)),
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset('assets/popcorn.png'),
      ),
      actions: [
        IconButton(
            onPressed: _openSearch,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
  }

  _openSearch() {}
}
