import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/movies_interface.dart';

class GetDetailsUsecase {
  final MediaRepository _repository;
  final DetailsDataSource _dataSource;
  GetDetailsUsecase(this._dataSource, this._repository);
  Future<Either<MediaRequestError, DetailsEntity>> call() async {
    return await _repository.getDetails(_dataSource);
  }
}
