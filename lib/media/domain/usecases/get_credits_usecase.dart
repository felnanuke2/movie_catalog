import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/media_repository.dart';

class GetCreditUsecase<T extends CreditEntity> {
  final CreditDataSource<T> _dataSource;
  final MediaRepository _repository;

  GetCreditUsecase(this._dataSource, this._repository);
  Future<Either<MediaRequestError, CreditEntity>> call() async =>
      await _repository.getCredits<T>(_dataSource);
}
