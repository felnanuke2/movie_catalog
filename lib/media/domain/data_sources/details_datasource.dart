import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';

abstract class DetailsDataSource {
  Future<DetailsEntity> call();
}
