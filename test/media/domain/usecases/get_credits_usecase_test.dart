import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/usecases/get_credits_usecase.dart';

import 'get_videos_usecase_test.dart';

class CreditsDatasourceMock<T extends CreditEntity> extends Mock
    implements CreditDataSource<T> {}

class CreditEntityMock extends Mock implements CreditEntity {}

void main() {
  final datasource = CreditsDatasourceMock<CreditEntity>();
  final mediaRepository = MediaRepositoryMock();

  test('Should call repository.getCredits() ', () async {
    final getcredits = GetCreditUsecase(
      datasource,
      mediaRepository,
    );

    when(() => mediaRepository.getCredits(datasource))
        .thenAnswer((invocation) async => Right(CreditEntityMock()));
    await getcredits();
    verify(() => mediaRepository.getCredits(datasource)).called(1);
  });
  test('return left on erro  ', () async {
    final getcredits = GetCreditUsecase<CreditEntity>(
      datasource,
      mediaRepository,
    );
    when(() => mediaRepository.getCredits(datasource)).thenAnswer(
        (invocation) async => Left(MediaRequestError(message: 'fake')));
    final result = await getcredits();
    expect(result, isA<Left<MediaRequestError, CreditEntity>>());
  });

  test('return right on success ', () async {
    final getcredits = GetCreditUsecase(
      datasource,
      mediaRepository,
    );
    when(() => mediaRepository.getCredits(datasource))
        .thenAnswer((invocation) async => Right(CreditEntityMock()));
    final result = await getcredits();

    expect(result, isA<Right<MediaRequestError, CreditEntity>>());
  });
}
