import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_catalog/core/api/api.dart';
import 'package:movie_catalog/core/interfaces/auth_interface.dart';
import 'package:movie_catalog/core/interfaces/movies_interface.dart';
import 'package:movie_catalog/core/interfaces/persistence_interface.dart';
import 'package:movie_catalog/core/interfaces/tv_interface.dart';
import 'package:movie_catalog/core/interfaces/user_interface.dart';
import 'package:movie_catalog/core/repositorys/tmdb/hive_persistence_repository.dart';
import 'package:movie_catalog/core/repositorys/tmdb/tmdb_auth_repository.dart';
import 'package:movie_catalog/core/repositorys/tmdb/tmdb_movies_reposioty.dart';
import 'package:movie_catalog/core/repositorys/tmdb/tmdb_tv_repository.dart';
import 'package:movie_catalog/core/repositorys/tmdb/tmdb_user_repository.dart';
import 'package:get/route_manager.dart';
import 'package:movie_catalog/screen/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initializeDep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _initializeDep() async {
    final persistence =
        Get.put<PersistenceInterface>(HivePersistenceRepository());
    await persistence.init();
    final auth = Get.put<AuthRepoInterface>(
        TmdbAuthrepository(persistence: persistence));
    final movies = Get.put<MoviesRepoInterface>(TmdbMoviesRepository());
    final series = Get.put<TvRepoInterface>(TmdbTvRepository());
    final user = Get.put<UserInterface>(TmdbUserRepository(auth, persistence));
    Get.put(Api(auth, movies, series, user, persistence));
    Get.offAll(() => HomeScreen());
    return;
  }
}
