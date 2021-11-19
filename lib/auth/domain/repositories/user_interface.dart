import 'package:dartz/dartz.dart';
import 'package:movie_catalog/auth/domain/error/auth_request_error.dart';
import 'package:movie_catalog/auth/domain/error/unauthenticated_user_error.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/entities/user.dart';

/// this repositry is responsible for managing the requests around user
/// Like rate ```Movies``` mark as ````Favorite```` or add to ```WatchList```

enum MediaType { Tv, Movie }

abstract class UserRepository {
  /// get the currentUser if is ```Signed```
  Either<AuthUnauthenticatedError, UserEntity> get currentUser;

  /// get user Movies ```whatchList```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<Media>>> getMoviesWatchList(
      {int page = 1});

  /// get user Movies ```Favorites```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<Media>>> getMoviesFavorites(
      {int page = 1});

  /// get user Movies ```Rated```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<Media>>> getMoviesRated({int page = 1});

  /// get user Tv ```whatchList```
  /// the ```page```by default is 1

  Future<Either<AuthRequestError, List<Media>>> getTvWachList({int page = 1});

  /// get user Tv ```Favorites```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<Media>>> getTvFavorites({int page = 1});

  /// get user Tv ```Rated```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<Media>>> getTvRated({int page = 1});

  /// mark a movie or tv serie as ```Favorite``` when ```favorite``` is ```true ```, when is false this will remove it.
  ///
  /// ```mediaType``` indicates the type of media being added, usually something like ```"Tv"``` or ```"Movie"```
  Future<Either<AuthRequestError, Media>> markAsFavorite(
      bool favorite, MediaType mediaType, Media media);

  /// Add a movie or tv serie to ```WatchList``` when ```watchList``` is ```true ```, when is false this will remove it.
  ///
  /// ```mediaType``` indicates the type of media being added, usually something like ```"Tv"``` or ```"Movie"```
  Future<Either<AuthRequestError, Media>> addToWatchList(
      bool watchlist, MediaType mediaType, Media media);

  /// Rate a movie ```rate``` is the user's vote.
  Future<Either<AuthRequestError, Media>> rateMovie(Media media, num rate);

  /// Rate a serie ```rate``` is the user's vote.
  Future<Either<AuthRequestError, Media>> rateSerie(Media media, num rate);
}
