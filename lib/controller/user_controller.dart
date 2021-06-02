import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/hive/hive_helper.dart';
import 'package:movie_catalog/homScreen/model/movie_item_model.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/controller/profile_controller.dart';
import 'package:movie_catalog/homScreen/tabs/profiletab/profile_tab.dart';
import 'package:movie_catalog/homScreen/widget/movie_item.dart';
import 'package:movie_catalog/user/usermodel.dart';
import 'package:url_launcher/url_launcher.dart';

class UserController {
  static bool cancelLogin = false;
  static bool loginSession = false;
  static Future<String> _getToken() async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/new?api_key=123cfdbadaa769bb037ba5a7a828a63a'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var requestToken = json['request_token'];
      return requestToken;
    }
    return '';
  }

  static createSession() async {
    loginSession = true;
    var requestToken = await _getToken();
    launch('https://www.themoviedb.org/authenticate/$requestToken');
    String? sessionID;
    await Future.delayed(Duration(seconds: 4));

    while (sessionID == null) {
      var request = await post(
          Uri.parse(
              'https://api.themoviedb.org/3/authentication/session/new?api_key=123cfdbadaa769bb037ba5a7a828a63a'),
          body: jsonEncode(
            {"request_token": requestToken},
          ),
          headers: {'Content-Type': 'application/json'});
      if (request.statusCode == 200) {
        var json = jsonDecode(request.body);
        var success = json['success'];
        if (success == true) {
          sessionID = json['session_id'];
          break;
        }
      }
      await Future.delayed(Duration(seconds: 2));
      if (cancelLogin) {
        break;
      }
    }
    if (cancelLogin) {
    } else {
      _getBaseUser(sessionID!);
    }
    loginSession = false;
  }

  static void _getBaseUser(String sessionId) async {
    var request = await get(
        Uri.parse('https://api.themoviedb.org/3/account?api_key=123cfdbadaa769bb037ba5a7a828a63a&'
            'session_id=$sessionId'));
    if (request.statusCode == 200) {
      var json = jsonDecode(request.body);
      var name = json['name'];
      var userName = json['username'];
      var incudeAdult = json['include_adult'];
      String? avatar;
      if (json['avatar']['tmdb']['avatar_path'] != null) {
        avatar = 'https://www.themoviedb.org/t/p/w150_and_h150_face' +
            json['avatar']['tmdb']['avatar_path'];
      }
      var userId = json['id'];
      var id =
          await HiveHelper.setCurrentUser(name, userName, incudeAdult, sessionId, avatar, userId);
    }
  }

  static void markAsFavorite(bool favorite, String mediaType, MovieItemModel movieItemModel) async {
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    final url = 'https://api.themoviedb.org/3/account/$id/favorite?api_key'
        '=123cfdbadaa769bb037ba5a7a828a63a&session_id=$sessionId';
    var request = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'media_type': mediaType,
          'media_id': movieItemModel.id,
          'favorite': favorite,
        }));
    if (favorite) {
      if (mediaType == 'movie') {
        ProfileController.movieFavorites.add(movieItemModel);
        ProfileController.movieFavoritesController.add(ProfileController.movieFavorites);
      } else {
        ProfileController.tvFavorites.add(movieItemModel);
        ProfileController.tvFavoritesController.add(ProfileController.tvFavorites);
      }
    } else {
      if (mediaType == 'movie') {
        ProfileController.movieFavorites
            .removeWhere((element) => element.id! == movieItemModel.id!);
        ProfileController.movieFavoritesController.add(ProfileController.movieFavorites);
      } else {
        ProfileController.tvFavorites.removeWhere((element) => element.id == movieItemModel.id);
        ProfileController.tvFavoritesController.add(ProfileController.tvFavorites);
      }
    }
  }

  static void addToWatchList(
      bool watchlist, String mediaType, MovieItemModel movieItemModel) async {
    var id = UserModel.instance.baseUser!.id;
    var sessionId = UserModel.instance.baseUser!.sessionID;
    final url = 'https://api.themoviedb.org/3/account/$id/watchlist?api_key'
        '=123cfdbadaa769bb037ba5a7a828a63a&session_id=$sessionId';
    var request = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'media_type': mediaType,
          'media_id': movieItemModel.id,
          'watchlist': watchlist,
        }));
    if (watchlist) {
      if (mediaType == 'movie') {
        ProfileController.movieWhactList.add(movieItemModel);
        ProfileController.movieWarchController.add(ProfileController.movieWhactList);
      } else {
        ProfileController.tvWhactList.add(movieItemModel);
        ProfileController.tvWarchController.add(ProfileController.tvWhactList);
      }
    } else {
      if (mediaType == 'movie') {
        ProfileController.movieWhactList
            .removeWhere((element) => element.id! == movieItemModel.id!);
        ProfileController.movieWarchController.add(ProfileController.movieWhactList);
      } else {
        ProfileController.tvWhactList.removeWhere((element) => element.id == movieItemModel.id);
        ProfileController.tvWarchController.add(ProfileController.tvWhactList);
      }
    }
  }

  static rateMovie(MovieItemModel movieItemModel, num rate) async {
    var sessionId = UserModel.instance.baseUser!.sessionID;
    final url = 'https://api.themoviedb.org/3/movie/${movieItemModel.id}/rating?api_key'
        '=123cfdbadaa769bb037ba5a7a828a63a&session_id=$sessionId';
    var request = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'value': rate,
        }));
    bool conatins = false;
    movieItemModel.rating = rate;
    var index = 0;
    ProfileController.movieRated.forEach((element) {
      if (element.id == movieItemModel.id) {
        ProfileController.movieRated[index] = movieItemModel;
        conatins = true;
      }
      index++;
    });
    if (!conatins) {
      ProfileController.movieRated.add(movieItemModel);
    }
    ProfileController.movieRatedController.add(ProfileController.movieRated);
  }

  static rateSerie(MovieItemModel movieItemModel, num rate) async {
    var sessionId = UserModel.instance.baseUser!.sessionID;
    final url = 'https://api.themoviedb.org/3/tv/${movieItemModel.id}/rating?api_key'
        '=123cfdbadaa769bb037ba5a7a828a63a&session_id=$sessionId';
    var request = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'value': rate,
        }));
    bool conatins = false;
    movieItemModel.rating = rate;
    var index = 0;
    ProfileController.tvRated.forEach((element) {
      if (element.id == movieItemModel.id) {
        ProfileController.tvRated[index] = movieItemModel;
        conatins = true;
      }
      index++;
    });
    if (!conatins) {
      ProfileController.tvRated.add(movieItemModel);
    }
    ProfileController.tvRatedController.add(ProfileController.tvRated);
  }

  static void loggout() {
    ProfileController.cleanAllLists();
    HiveHelper.loggout();
  }
}
