// import 'dart:convert';

// import 'package:http/http.dart';

// import 'package:movie_catalog/constant/api_key.dart';
// import 'package:movie_catalog/core/interfaces/auth_interface.dart';
// import 'package:movie_catalog/core/interfaces/persistence_interface.dart';
// import 'package:movie_catalog/core/interfaces/user_interface.dart';
// import 'package:movie_catalog/core/model/auth/tmdb_user_auth.dart';
// import 'package:movie_catalog/core/model/base_user.dart';
// import 'package:movie_catalog/core/model/enums/enums.dart';
// import 'package:movie_catalog/core/model/movie_item_model.dart';

// class TmdbUserRepository extends UserInterface {
//   final AuthRepoInterface _auth;
//   final PersistenceInterface persistence;
//   TmdbUserAuth get _authUser => _auth.getUserAuth as TmdbUserAuth;

//   @override
//   BaseUser? get currentUser => persistence.currentUser;

//   TmdbUserRepository(
//     this._auth,
//     this.persistence,
//   );

//   Future<List<MovieItemModel>> getMoviesWatchList(
//       {bool? add, int page = 1}) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     var requestURL = 'https://api.themoviedb.org/3/account/$id/watchlist'
//         '/movies?api_key=$TMDB_API_KEY&session_'
//         'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$page';
//     var request = await get(Uri.parse(requestURL));
//     if (request.statusCode != 200) throw request.body;
//     final json = jsonDecode(request.body);
//     final list = List.from(json['results'])
//         .map((e) => MovieItemModel.fromJson(e))
//         .toList();
//     return list;
//   }

//   Future<List<MovieItemModel>> getMoviesFavorites(
//       {bool? add, int page = 1}) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     var requestURL = 'https://api.themoviedb.org/3/account/$id/favorite'
//         '/movies?api_key=$TMDB_API_KEY&session_'
//         'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$page';
//     var request = await get(Uri.parse(requestURL));
//     if (request.statusCode != 200) throw request.body;
//     final json = jsonDecode(request.body);
//     final list = List.from(json['results'])
//         .map((e) => MovieItemModel.fromJson(e))
//         .toList();
//     return list;
//   }

//   Future<List<MovieItemModel>> getMoviesRated({bool? add, int page = 1}) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     var requestURL = 'https://api.themoviedb.org/3/account/$id/rated'
//         '/movies?api_key=$TMDB_API_KEY&session_'
//         'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$page';
//     var request = await get(Uri.parse(requestURL));
//     if (request.statusCode != 200) throw request.body;
//     final json = jsonDecode(request.body);
//     final list = List.from(json['results'])
//         .map((e) => MovieItemModel.fromJson(e))
//         .toList();
//     return list;
//   }

//   Future<List<MovieItemModel>> getTvWachList({bool? add, int page = 1}) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     var requestURL = 'https://api.themoviedb.org/3/account/$id/watchlist'
//         '/tv?api_key=$TMDB_API_KEY&session_'
//         'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$page';
//     var request = await get(Uri.parse(requestURL));
//     if (request.statusCode != 200) throw request.body;
//     final json = jsonDecode(request.body);
//     final list = List.from(json['results'])
//         .map((e) => MovieItemModel.fromJson(e))
//         .toList();
//     return list;
//   }

//   Future<List<MovieItemModel>> getTvFavorites({bool? add, int page = 1}) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     var requestURL = 'https://api.themoviedb.org/3/account/$id/favorite'
//         '/tv?api_key=$TMDB_API_KEY&session_'
//         'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$page';
//     var request = await get(Uri.parse(requestURL));
//     if (request.statusCode != 200) throw request.body;
//     final json = jsonDecode(request.body);
//     final list = List.from(json['results'])
//         .map((e) => MovieItemModel.fromJson(e))
//         .toList();
//     return list;
//   }

//   Future<List<MovieItemModel>> getTvRated({bool? add, int page = 1}) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     final requestURL = 'https://api.themoviedb.org/3/account/$id/rated'
//         '/tv?api_key=$TMDB_API_KEY&session_'
//         'id=$sessionId&language=pt-BR&&sort_by=created_at.desc&page=$page';
//     var request = await get(Uri.parse(requestURL));
//     if (request.statusCode != 200) throw request.body;
//     var json = jsonDecode(request.body);
//     var list = List.from(json['results'])
//         .map((e) => MovieItemModel.fromJson(e))
//         .toList();
//     return list;
//   }

//   Future<MovieItemModel> markAsFavorite(
//       bool favorite, MediaType mediaType, MovieItemModel movieItemModel) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     final url = 'https://api.themoviedb.org/3/account/$id/favorite?api_key'
//         '=$TMDB_API_KEY&session_id=$sessionId';
//     var request = await post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'media_type': mediaType.toValueString(),
//           'media_id': movieItemModel.id,
//           'favorite': favorite,
//         }));
//     if (request.statusCode != 200) throw request.body;

//     return movieItemModel;
//   }

//   /// media
//   Future<MovieItemModel> addToWatchList(bool watchlist, MediaType mediaType,
//       MovieItemModel movieItemModel) async {
//     var id = _authUser.sessionId;
//     var sessionId = _authUser.sessionId;
//     final url = 'https://api.themoviedb.org/3/account/$id/watchlist?api_key'
//         '=$TMDB_API_KEY&session_id=$sessionId';
//     var request = await post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'media_type': mediaType.toValueString(),
//           'media_id': movieItemModel.id,
//           'watchlist': watchlist,
//         }));
//     if (request.statusCode != 200) throw request.body;

//     return movieItemModel;
//   }

//   Future<MovieItemModel> rateMovie(
//       MovieItemModel movieItemModel, num rate) async {
//     var sessionId = _authUser.sessionId;
//     final url =
//         'https://api.themoviedb.org/3/movie/${movieItemModel.id}/rating?api_key'
//         '=$TMDB_API_KEY&session_id=$sessionId';
//     var request = await post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'value': rate,
//         }));
//     if (request.statusCode != 200) throw request.body;

//     movieItemModel.rating = rate;
//     return movieItemModel;
//   }

//   Future<MovieItemModel> rateSerie(
//       MovieItemModel movieItemModel, num rate) async {
//     var sessionId = _authUser.sessionId;
//     final url =
//         'https://api.themoviedb.org/3/tv/${movieItemModel.id}/rating?api_key'
//         '=$TMDB_API_KEY&session_id=$sessionId';
//     var request = await post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'value': rate,
//         }));
//     if (request.statusCode != 200) throw request.body;
//     movieItemModel.rating = rate;

//     return movieItemModel;
//   }
// }

// extension _ConvertMediaType on MediaType {
//   String toValueString() {
//     String value;
//     if (this == MediaType.Tv) {
//       value = 'tv';
//     } else {
//       value = 'movie';
//     }
//     return value;
//   }
// }
