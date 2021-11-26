import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/media_repository.dart';

class GetVideosUsecase<T extends VideoEntity> {
  final MediaRepository _repository;
  final VideoDataSource<T> _dataSource;
  GetVideosUsecase(
    this._repository,
    this._dataSource,
  );

  Future<Either<MediaRequestError, List<T>>> call() async =>
      await _repository.getVideosList<T>(_dataSource);
}
