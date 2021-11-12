import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/controller/movie_tab_controller.dart';
import 'package:movie_catalog/controller/session_controller.dart';
import 'package:movie_catalog/core/model/base_user.dart';
import 'package:movie_catalog/widget/persistent_header_search_bar.dart';
import 'package:movie_catalog/widget/sliverListTitles.dart';

class MovieTab extends StatefulWidget {
  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab>
    with AutomaticKeepAliveClientMixin<MovieTab> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MovieTabController>(
      init: MovieTabController(),
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 45,
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                final user = Get.find<SessionController>().currentUser.value;
                if (user != null) return _buildUserHeaders(user);
                return _buildAnonHeaders();
              }),
            ),
            PersistentHeaderSearchBar(SearchType.Movie),
            SliverListTitles(
                initialData: controller.popularMovies,
                stream: controller.popularMovies.stream,
                title: 'Filmes Populares',
                addFunction: controller.getPopularMovies),
            SliverListTitles(
                initialData: controller.upcomingMovies,
                stream: controller.upcomingMovies.stream,
                title: 'Em Breve',
                addFunction: controller.getUpcomingMovies),
            SliverListTitles(
                initialData: controller.onAirMovies,
                stream: controller.onAirMovies.stream,
                title: 'Nos Cinemas',
                addFunction: controller.getPLayNowMovies),
            SliverListTitles(
                initialData: controller.topRatedMovies,
                stream: controller.topRatedMovies.stream,
                title: 'Top Rated',
                addFunction: controller.getTopRatedMovies),
          ],
        ),
      ),
    );
  }

  ListTile _buildAnonHeaders() {
    return ListTile(
      title: Text(
        'Olá Visitante',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        'Escolha seus Filmes e Séries Favoritos',
        style: TextStyle(color: Colors.white.withOpacity(0.6)),
      ),
      trailing: Container(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: FlutterLogo(),
        ),
      ),
    );
  }

  ListTile _buildUserHeaders(BaseUser user) {
    return ListTile(
      title: Text(
        'Olá ${user.userName}',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        'Escolha seus Filmes e Séries Favoritos',
        style: TextStyle(color: Colors.white.withOpacity(0.6)),
      ),
      trailing: Container(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child:
              user.avatar != null ? Image.network(user.avatar!) : FlutterLogo(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
