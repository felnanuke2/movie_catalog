import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/movies_interface.dart';

class GetVideosUsecase {
  final MediaRepository _repository;
  final VideoDataSource _dataSource;
  GetVideosUsecase(
    this._repository,
    this._dataSource,
  );

  Future<Either<MediaRequestError, List<VideoEntity>>> call() async {
    return await _repository.getVideosList(_dataSource);
  }
}
