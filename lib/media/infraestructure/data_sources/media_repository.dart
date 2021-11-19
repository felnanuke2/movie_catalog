import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';

abstract class MediaDataSource {
  /// get popular Movies and can be receive a index of ```page = 1``` if null
  Future<Either<MediaRequestError, List<Media>>> getPopularMovies(
      {int page = 1});

  /// get upcoming Movies and can be receive a index of ```page = 1``` if null
  Future<Either<MediaRequestError, List<Media>>> getUpcomingMovies(
      {int page = 1});

  /// make a query and receive data the ``` query ```
  Future<Either<MediaRequestError, List<Media>>> search(String query);

  /// get liveNow Movies and can be receive a index of ```page = 1``` if null

  Future<Either<MediaRequestError, List<Media>>> getPlayNowMovies(
      {int page = 1});

  /// get topRated Movies and can be receive a index of ```page = 1``` if null
  Future<Either<MediaRequestError, List<Media>>> getTopRated({int page = 1});

  /// need receive a ```movieId``` to get the credit of a Movie.
  /// the credit  contains ```Crew``` and ```Cast``` of a Src.
  Future<CreditEntity> getCredits(
    String movieId,
  );

  /// Need receive a ```movieId``` to get the Movie Details.
  Future<Either<MediaRequestError, DetailsEntity>> getDetails(String id);

  /// Get the related videos like ```Trailers``` ```MakingOf``` ...
  Future<Either<MediaRequestError, List<VideoEntity>>> getVideosList(String id);

  /// Get The recommended or similar like a ```Movies``` or ```Series```
  Future<Either<MediaRequestError, List<Media>>> getRecomendations(String id);
}
