import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/homScreen/widget/home_search_dlegate.dart';
import 'package:movie_catalog/homScreen/widget/sliver_app_bar_delegate.dart';

class PersistentHeaderSearchBar extends StatelessWidget {
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
              showSearch(context: context, delegate: HomeSearch());
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
