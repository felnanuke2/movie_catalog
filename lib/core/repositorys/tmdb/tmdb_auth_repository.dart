import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/core/interfaces/auth_interface.dart';
import 'package:movie_catalog/core/interfaces/persistence_interface.dart';
import 'package:movie_catalog/core/interfaces/user_auth.dart';
import 'package:movie_catalog/core/model/auth/tmdb_user_auth.dart';
import 'package:movie_catalog/core/model/base_user.dart';

class TmdbAuthrepository implements AuthRepoInterface {
  final PersistenceInterface persistence;
  TmdbAuthrepository({
    required this.persistence,
  });

  BaseUser? get currentUser => persistence.currentUser;

  @override
  TmdbUserAuth? get getUserAuth => UserAuth(args: {
        'session_id': currentUser?.sessionID,
        'user_id': currentUser?.id
      }).asTmdbAuth();

  @override
  Future<BaseUser> signIn(String sessionId) async {
    return await _getBaseUser(sessionId);
  }

  @override
  Future signOut() async {
    await persistence.clearUser();
  }

  Future<String> _getToken() async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/new?api_key=$API_KEY'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    var requestToken = json['request_token'];
    return requestToken;
  }

  Future<String> createSession() async {
    var requestToken = await _getToken();
    return 'https://www.themoviedb.org/authenticate/$requestToken';
  }

  Future<BaseUser> _getBaseUser(String sessionId) async {
    var request = await get(
        Uri.parse('https://api.themoviedb.org/3/account?api_key=$API_KEY&'
            'session_id=$sessionId'));
    if (request.statusCode != 200) throw request.body;
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
    final user = BaseUser(
      id: userId,
      avatar: avatar,
      incudeAdult: incudeAdult,
      name: name,
      sessionID: sessionId,
      userName: userName,
    );
    await persistence.saveUser(user);
    return user;
  }
}
