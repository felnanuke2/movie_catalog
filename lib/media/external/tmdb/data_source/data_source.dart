import 'package:movie_catalog/media/infraestructure/data_sources/media_repository.dart';

class TbdmMediaDataSource implements MediaDataSource {
  @override
  Future<List<MovieItemModel>> getPlayNowMovies({int page = 1}) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final playnowMovies = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return playnowMovies;
  }

  @override
  Future<List<MovieItemModel>> getPopularMovies({int page = 1}) async {
    final request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    var moviesList = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return moviesList;
  }

  @override
  Future<List<MovieItemModel>> getTopRated({int page = 1}) async {
    final request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final topRatedMovies = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return topRatedMovies;
  }

  @override
  Future<List<MovieItemModel>> getUpcomingMovies({int page = 1}) async {
    final request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$API_KEY&language=pt-br&page=$page'));
    if (request.statusCode != 200) throw request.body;
    final json = jsonDecode(request.body);
    final moviesList = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    return moviesList;
  }

  @override
  Future<List<MovieItemModel>> search(String query) async {
    final request = await get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language= pt-br&query=$query'));
    if (request.statusCode != 200) throw request.body;
    final json = jsonDecode(request.body);
    final search = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    search.sort((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    });
    return search;
  }

  @override
  Future<CreditModel> getCredits(
    String movieId,
  ) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$API_KEY&language=pt-br'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final creditModel = CreditModel.fromJson(json);
    creditModel.cast!.sort((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    });
    return creditModel;
  }

  @override
  Future<MovieModelDetail> getDetails(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$API_KEY&language=pt-br'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final movieModelDetail = MovieModelDetail.fromJson(json);
    return movieModelDetail;
  }

  @override
  Future<List<MovieVideoModel>> getVideosList(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$API_KEY'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final listVideoModel = List.from(json['results'])
        .map((e) => MovieVideoModel.fromJson(e))
        .toList();
    listVideoModel.removeWhere((element) => element.site != 'YouTube');
    return listVideoModel;
  }

  @override
  Future<List<MovieItemModel>> getRecomendations(String id) async {
    var request = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=$API_KEY&language=pt-br'));
    if (request.statusCode != 200) throw request.body;
    var json = jsonDecode(request.body);
    final recomendationsList = List.from(json['results'])
        .map((e) => MovieItemModel.fromJson(e))
        .toList();
    recomendationsList.sort((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    });
    return recomendationsList;
  }
}
