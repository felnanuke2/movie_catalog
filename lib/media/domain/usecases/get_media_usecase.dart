import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/movies_interface.dart';

class GetMediaUsecase {
  final MediaRepository _repository;
  final MediaDataSource _dataSource;
  GetMediaUsecase(this._dataSource, this._repository);
  Future<Either<MediaRequestError, List<MediaEntity>>> call() async {
    return await _repository.getMedia(_dataSource);
  }
}
