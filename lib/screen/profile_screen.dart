import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_catalog/controller/profile_controller.dart';
import 'package:movie_catalog/widget/GridViewItemsProfile.dart';
import 'package:movie_catalog/widget/counter_profile_Widget.dart';
import 'package:movie_catalog/controller/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  BaseUser? user;
  ProfileScreen(this.user);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController? _pageController;
  TabController? _movieorTvController;
  var _streamController = StreamController<double>.broadcast();
  @override
  void initState() {
    if (widget.user != null) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {});
      _pageController = TabController(length: 3, vsync: this);
      _movieorTvController = TabController(length: 2, vsync: this);
    }
    super.initState();
  }

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  leading: widget.user!.avatar != null
                      ? Image.network(widget.user!.avatar!)
                      : FlutterLogo(),
                  title: Text(
                    widget.user!.userName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _requestLoggout(context);
                },
                child: Text(
                  'Sair',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _moviesOrTvSelectRow(),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: TabBarView(controller: _movieorTvController, children: [
            Column(
              children: [
                _divider(),
                _infosRowMovies(),
                _divider(),
                Expanded(
                  child: TabBarView(
                    controller: _pageController!,
                    children: [
                      GridUserProfile(
                        addFun: ProfileController.getMoviesWachList,
                        initialdata: ProfileController.movieWhactList,
                        stream: ProfileController.moviesWachListController,
                      ),
                      GridUserProfile(
                        addFun: ProfileController.getMoviesFavorites,
                        initialdata: ProfileController.movieFavorites,
                        stream: ProfileController.moviesFavoritesListController,
                      ),
                      GridUserProfile(
                        addFun: ProfileController.getMoviesRated,
                        initialdata: ProfileController.movieRated,
                        stream: ProfileController.moviesRatedListController,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                _divider(),
                _infosRowTv(),
                _divider(),
                Expanded(
                  child: TabBarView(
                    controller: _pageController!,
                    children: [
                      GridUserProfile(
                        addFun: ProfileController.getTvWachList,
                        initialdata: ProfileController.tvWhactList,
                        stream: ProfileController.tvWachListController,
                        tv: true,
                      ),
                      GridUserProfile(
                        addFun: ProfileController.getTvFavorites,
                        initialdata: ProfileController.tvFavorites,
                        stream: ProfileController.tvFavoritesListController,
                        tv: true,
                      ),
                      GridUserProfile(
                        addFun: ProfileController.getTvRated,
                        initialdata: ProfileController.tvRated,
                        stream: ProfileController.tvRatedListController,
                        tv: true,
                      ),
                    ],
                  ),
                )
              ],
            )
          ]),
        )
      ],
    );
  }

  _requestLoggout(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
            child: AlertDialog(
          title: Text('Deseja Sair da Sua Conta?'),
          content: Column(
            children: [
              Text(
                'Ao confirmar, essa sessão será encerrada.',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Sair',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ));
      },
    );
    if (result == true) {
      UserController.loggout();
    }
  }

  Widget _moviesOrTvSelectRow() {
    return TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(fontSize: 18),
        labelPadding: EdgeInsets.all(8),
        controller: _movieorTvController,
        tabs: [
          Text(
            'Filmes',
          ),
          Text(
            'Séries',
          )
        ]);
  }

  Padding _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 30,
        color: Colors.white,
      ),
    );
  }

  Widget _infosRowMovies() {
    return TabBar(
      controller: _pageController,
      unselectedLabelColor: Colors.white.withOpacity(0.4),
      isScrollable: true,
      indicatorColor: Colors.white,
      tabs: [
        CounterProfileWidget(
          initialData: ProfileController.movieWhactList,
          stream: ProfileController.moviesWachListController,
          title: 'Interesses',
        ),
        CounterProfileWidget(
          initialData: ProfileController.movieFavorites,
          stream: ProfileController.moviesFavoritesListController,
          title: 'Favoritos',
        ),
        CounterProfileWidget(
          initialData: ProfileController.movieRated,
          stream: ProfileController.moviesRatedListController,
          title: 'Votados',
        ),
      ],
    );
  }

  Widget _infosRowTv() {
    return TabBar(
      controller: _pageController,
      unselectedLabelColor: Colors.white.withOpacity(0.4),
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      isScrollable: true,
      indicatorColor: Colors.white,
      tabs: [
        CounterProfileWidget(
          initialData: ProfileController.tvWhactList,
          stream: ProfileController.tvWachListController,
          title: 'Interesses',
        ),
        CounterProfileWidget(
          initialData: ProfileController.tvFavorites,
          stream: ProfileController.tvFavoritesListController,
          title: 'Favoritos',
        ),
        CounterProfileWidget(
          initialData: ProfileController.tvRated,
          stream: ProfileController.tvRatedListController,
          title: 'Votados',
        ),
      ],
    );
  }
}
