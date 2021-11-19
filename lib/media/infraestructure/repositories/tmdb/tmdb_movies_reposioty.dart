import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/movies_interface.dart';
import 'package:movie_catalog/media/infraestructure/data_sources/media_repository.dart';

class TmdbMoviesRepository implements MediaRepository {
  final MediaDataSource dataSource;

  TmdbMoviesRepository({
    required this.dataSource,
  });

  @override
  Future<CreditEntity> getCredits(String movieId) {
    // TODO: implement getCredits
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, DetailsEntity>> getDetails(String id) {
    // TODO: implement getDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<Media>>> getPlayNowMovies(
      {int page = 1}) {
    // TODO: implement getPlayNowMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<Media>>> getPopularMovies(
      {int page = 1}) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<Media>>> getRecomendations(String id) {
    // TODO: implement getRecomendations
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<Media>>> getTopRated({int page = 1}) {
    // TODO: implement getTopRated
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<Media>>> getUpcomingMovies(
      {int page = 1}) {
    // TODO: implement getUpcomingMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<VideoEntity>>> getVideosList(
      String id) {
    // TODO: implement getVideosList
    throw UnimplementedError();
  }

  @override
  Future<Either<MediaRequestError, List<Media>>> search(String query) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
