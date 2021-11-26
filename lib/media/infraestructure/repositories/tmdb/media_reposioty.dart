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
import 'package:movie_catalog/media/domain/repositories/media_repository.dart';

class MediaRepositoryImplementation implements MediaRepository {
  @override
  Future<Either<MediaRequestError, T>> getCredits<T extends CreditEntity>(
      CreditDataSource<T> dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }

  @override
  Future<Either<MediaRequestError, T>> getDetails<T extends DetailsEntity>(
      DetailsDataSource<T> dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }

  @override
  Future<Either<MediaRequestError, List<T>>> getMedia<T extends MediaEntity>(
      MediaDataSource<T> dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }

  @override
  Future<Either<MediaRequestError, List<T>>>
      getVideosList<T extends VideoEntity>(
          VideoDataSource<T> dataSource) async {
    try {
      final result = await dataSource();
      return Right(result);
    } on MediaRequestError catch (e, s) {
      return Left(e..stackTrace = s);
    }
  }
}
