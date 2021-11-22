import 'package:dartz/dartz.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/movies_interface.dart';

class GetCreditUsecase {
  final CreditDataSource _dataSource;
  final MediaRepository _repository;
  GetCreditUsecase(this._dataSource, this._repository);
  Future<Either<MediaRequestError, CreditEntity>> call() async {
    return await _repository.getCredits(_dataSource);
  }
}
