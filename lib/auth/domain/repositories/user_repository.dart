import 'package:dartz/dartz.dart';
import 'package:movie_catalog/auth/domain/entities/user.dart';
import 'package:movie_catalog/auth/domain/error/auth_request_error.dart';
import 'package:movie_catalog/auth/domain/error/unauthenticated_user_error.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';

/// this repositry is responsible for managing the requests around user
/// Like rate ```Movies``` mark as ````Favorite```` or add to ```WatchList```

enum MediaType { Tv, Movie }

abstract class UserRepository {
  /// get the currentUser if is ```Signed```
  Either<AuthUnauthenticatedError, UserEntity> get currentUser;

  /// get user Movies ```whatchList```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<MediaEntity>>> getMoviesWatchList(
      {int page = 1});

  /// get user Movies ```Favorites```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<MediaEntity>>> getMoviesFavorites(
      {int page = 1});

  /// get user Movies ```Rated```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<MediaEntity>>> getMoviesRated(
      {int page = 1});

  /// get user Tv ```whatchList```
  /// the ```page```by default is 1

  Future<Either<AuthRequestError, List<MediaEntity>>> getTvWachList(
      {int page = 1});

  /// get user Tv ```Favorites```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<MediaEntity>>> getTvFavorites(
      {int page = 1});

  /// get user Tv ```Rated```
  /// the ```page```by default is 1
  Future<Either<AuthRequestError, List<MediaEntity>>> getTvRated(
      {int page = 1});

  /// mark a movie or tv serie as ```Favorite``` when ```favorite``` is ```true ```, when is false this will remove it.
  ///
  /// ```mediaType``` indicates the type of media being added, usually something like ```"Tv"``` or ```"Movie"```
  Future<Either<AuthRequestError, MediaEntity>> markAsFavorite(
      bool favorite, MediaType mediaType, MediaEntity media);

  /// Add a movie or tv serie to ```WatchList``` when ```watchList``` is ```true ```, when is false this will remove it.
  ///
  /// ```mediaType``` indicates the type of media being added, usually something like ```"Tv"``` or ```"Movie"```
  Future<Either<AuthRequestError, MediaEntity>> addToWatchList(
      bool watchlist, MediaType mediaType, MediaEntity media);

  /// Rate a movie ```rate``` is the user's vote.
  Future<Either<AuthRequestError, MediaEntity>> rateMovie(
      MediaEntity media, num rate);

  /// Rate a serie ```rate``` is the user's vote.
  Future<Either<AuthRequestError, MediaEntity>> rateSerie(
      MediaEntity media, num rate);
}
