import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movie_catalog/controller/profile_controller.dart';
import 'package:movie_catalog/widget/GridViewItemsProfile.dart';
import 'package:movie_catalog/widget/counter_profile_Widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(vsync: this),
      builder: (controller) => Column(
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
                    leading: controller.user!.avatar != null
                        ? Image.network(controller.user!.avatar!)
                        : FlutterLogo(),
                    title: Text(
                      controller.user!.userName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _requestLoggout(context, controller);
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
          _moviesOrTvSelectRow(controller),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
                controller: controller.serieOrTvTabController,
                children: [
                  _buildMoviesTab(controller),
                  _buildSeriesTab(controller)
                ]),
          )
        ],
      ),
    );
  }

  Column _buildSeriesTab(ProfileController controller) {
    return Column(
      children: [
        _divider(),
        _infosRowTv(controller),
        _divider(),
        Expanded(
          child: TabBarView(
            controller: controller.seriesTabController,
            children: [
              GridUserProfile(
                addFun: controller.getTvWachList,
                initialdata: controller.tvWhactList,
                stream: controller.tvWhactList.stream,
                tv: true,
              ),
              GridUserProfile(
                addFun: controller.getTvFavorites,
                initialdata: controller.tvFavorites,
                stream: controller.tvFavorites.stream,
                tv: true,
              ),
              GridUserProfile(
                addFun: controller.getTvRated,
                initialdata: controller.tvRated,
                stream: controller.tvRated.stream,
                tv: true,
              ),
            ],
          ),
        )
      ],
    );
  }

  Column _buildMoviesTab(ProfileController controller) {
    return Column(
      children: [
        _divider(),
        _infosRowMovies(controller),
        _divider(),
        Expanded(
          child: TabBarView(
            controller: controller.moviesTabController,
            children: [
              GridUserProfile(
                addFun: controller.getMoviesWachList,
                initialdata: controller.movieWhactList,
                stream: controller.movieWhactList.stream,
              ),
              GridUserProfile(
                addFun: controller.getMoviesFavorites,
                initialdata: controller.movieFavorites,
                stream: controller.movieFavorites.stream,
              ),
              GridUserProfile(
                addFun: controller.getMoviesRated,
                initialdata: controller.movieRated,
                stream: controller.movieRated.stream,
              ),
            ],
          ),
        )
      ],
    );
  }

  _requestLoggout(BuildContext context, ProfileController controller) async {
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
      controller.signOut();
    }
  }

  Widget _moviesOrTvSelectRow(ProfileController controller) {
    return TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(fontSize: 18),
        labelPadding: EdgeInsets.all(8),
        controller: controller.serieOrTvTabController,
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

  Widget _infosRowMovies(ProfileController controller) {
    return TabBar(
      controller: controller.moviesTabController,
      unselectedLabelColor: Colors.white.withOpacity(0.4),
      isScrollable: true,
      indicatorColor: Colors.white,
      tabs: [
        CounterProfileWidget(
          initialData: controller.movieWhactList,
          stream: controller.movieWhactList.stream,
          title: 'Interesses',
        ),
        CounterProfileWidget(
          initialData: controller.movieFavorites,
          stream: controller.movieFavorites.stream,
          title: 'Favoritos',
        ),
        CounterProfileWidget(
          initialData: controller.movieRated,
          stream: controller.movieRated.stream,
          title: 'Votados',
        ),
      ],
    );
  }

  Widget _infosRowTv(ProfileController controller) {
    return TabBar(
      controller: controller.serieOrTvTabController,
      unselectedLabelColor: Colors.white.withOpacity(0.4),
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      isScrollable: true,
      indicatorColor: Colors.white,
      tabs: [
        CounterProfileWidget(
          initialData: controller.tvWhactList,
          stream: controller.tvWhactList.stream,
          title: 'Interesses',
        ),
        CounterProfileWidget(
          initialData: controller.tvFavorites,
          stream: controller.tvFavorites.stream,
          title: 'Favoritos',
        ),
        CounterProfileWidget(
          initialData: controller.tvRated,
          stream: controller.tvRated.stream,
          title: 'Votados',
        ),
      ],
    );
  }
}
