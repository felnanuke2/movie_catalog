import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant.dart';

class MovieTvShowNavigationBar extends StatefulWidget {
  MovieTvShowNavigationBar(
      {required this.currentPage, required this.pageController});

  int currentPage;
  PageController? pageController;

  @override
  _MovieTvShowNavigationBarState createState() =>
      _MovieTvShowNavigationBarState();
}

class _MovieTvShowNavigationBarState extends State<MovieTvShowNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white.withOpacity(0.4),
        backgroundColor: BACKGROUND_COLOR,
        elevation: 4,
        currentIndex: widget.currentPage,
        onTap: (value) {
          widget.currentPage = value;
          widget.pageController!.animateToPage(value,
              duration: Duration(milliseconds: 450),
              curve: Curves.linearToEaseOut);
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.movie),
                  if (widget.currentPage == 0)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    )
                ],
              ),
              label: 'Filmes'),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.tv),
                  if (widget.currentPage == 1)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    )
                ],
              ),
              label: 'Séries'),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.person),
                  if (widget.currentPage == 2)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    )
                ],
              ),
              label: 'Perfil'),
        ]);
  }
}
