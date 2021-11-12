import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:movie_catalog/constant/api_key.dart';
import 'package:movie_catalog/core/interfaces/auth_interface.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_catalog/core/interfaces/user_auth.dart';
import 'package:movie_catalog/core/model/auth/tmdb_user_auth.dart';
import 'package:movie_catalog/core/model/base_user.dart';

const _USER_BOX = 'user_box';
const CURRENT_USER = 'current_user';

class TmdbAuthrepository implements AuthRepoInterface {
  late Box<BaseUser> _userBox;
  BaseUser? get currentUser => _userBox.get(CURRENT_USER);

  @override
  TmdbUserAuth? get getUserAuth => UserAuth(args: {
        'session_id': currentUser?.sessionID,
        'user_id': currentUser?.id
      }).asTmdbAuth();

  @override
  Future<void> initilize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BaseUserAdapter());
    _userBox = await Hive.openBox(_USER_BOX);
  }

  @override
  Future<BaseUser> signIn(String sessionId) async {
    return await _getBaseUser(sessionId);
  }

  @override
  Future signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
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
    await _userBox.put(CURRENT_USER, user);
    return user;
  }
}
