import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/movies_interface.dart';

class MediaRepositoryImplementation implements MediaRepository {
  @override
  Future<Either<MediaRequestError, CreditEntity>> getCredits(
      CreditDataSource dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }

  @override
  Future<Either<MediaRequestError, DetailsEntity>> getDetails(
      DetailsDataSource dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }

  @override
  Future<Either<MediaRequestError, List<MediaEntity>>> getMedia(
      MediaDataSource dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }

  @override
  Future<Either<MediaRequestError, List<VideoEntity>>> getVideosList(
      VideoDataSource dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }
}
