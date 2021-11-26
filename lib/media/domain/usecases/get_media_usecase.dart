import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/media_repository.dart';

class GetMediaUsecase<T extends MediaEntity> {
  final MediaRepository _repository;
  final MediaDataSource<T> _dataSource;
  GetMediaUsecase(this._dataSource, this._repository);
  Future<Either<MediaRequestError, List<T>>> call() async =>
      await _repository.getMedia<T>(_dataSource);
}
