import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/ultils/home_search_delegate.dart';
import 'package:movie_catalog/ultils/sliver_app_bar_delegate.dart';

enum SearchType {
  Tv,
  Movie,
}

class PersistentHeaderSearchBar extends StatelessWidget {
  String? type;
  PersistentHeaderSearchBar(SearchType searchType) {
    if (searchType == SearchType.Movie) {
      this.type = 'movie';
    } else {
      this.type = 'tv';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        floating: true,
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 105,
          maxHeight: 105,
          child: TextField(
            onTap: () {
              showSearch(context: context, delegate: HomeSearch(type));
            },
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              fillColor: BACKGROUND_COLOR,
              hintText: 'Pesquisar',
            ),
          ),
        ));
    ;
  }
}
