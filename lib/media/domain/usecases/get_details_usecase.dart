import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/media_repository.dart';

class GetDetailsUsecase<T extends DetailsEntity> {
  final MediaRepository _repository;
  final DetailsDataSource<T> _dataSource;
  GetDetailsUsecase(this._dataSource, this._repository);
  Future<Either<MediaRequestError, T>> call() async =>
      await _repository.getDetails(_dataSource);
}
