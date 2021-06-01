import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/hive/hive_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class UserController {
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
    var requestToken = await _getToken();
    launch('https://www.themoviedb.org/authenticate/$requestToken');
    String? sessionID;
    await Future.delayed(Duration(seconds: 4));
    bool canceled = false;

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
      if (canceled) {
        break;
      }
    }
    _getBaseUser(sessionID!);
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
      await HiveHelper.setCurrentUser(name, userName, incudeAdult, sessionId);
    }
  }
}
