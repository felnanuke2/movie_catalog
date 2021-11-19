/// this repository is responsible for managing all request involving [Movies]
abstract class MoviesRepoInterface {
  /// get popular Movies and can be receive a index of ```page = 1``` if null
  Future<List<MovieItemModel>> getPopularMovies({int page = 1});

  /// get upcoming Movies and can be receive a index of ```page = 1``` if null
  Future<List<MovieItemModel>> getUpcomingMovies({int page = 1});

  /// make a query and receive data the ``` query ```
  Future<List<MovieItemModel>> search(String query);

  /// get liveNow Movies and can be receive a index of ```page = 1``` if null

  Future<List<MovieItemModel>> getPlayNowMovies({int page = 1});

  /// get topRated Movies and can be receive a index of ```page = 1``` if null
  Future<List<MovieItemModel>> getTopRated({int page = 1});

  /// need receive a ```movieId``` to get the credit of a Movie.
  /// the credit  contains ```Crew``` and ```Cast``` of a Src.
  Future<CreditModel> getCredits(
    String movieId,
  );

  /// Need receive a ```movieId``` to get the Movie Details.
  Future<MovieModelDetail> getDetails(String id);

  /// Get the related videos like ```Trailers``` ```MakingOf``` ...
  Future<List<MovieVideoModel>> getVideosList(String id);

  /// Get The recommended or similar like a ```Movies``` or ```Series```
  Future<List<MovieItemModel>> getRecomendations(String id);
}
