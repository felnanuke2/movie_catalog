import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/data_sources/details_datasource.dart';
import 'package:movie_catalog/media/domain/entities/detail.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/usecases/get_details_usecase.dart';

import 'get_videos_usecase_test.dart';

class DetailsDatasourceMock extends Mock implements DetailsDataSource {}

class DetailsEntityMock extends Mock implements DetailsEntity {}

void main() {
  final repository = MediaRepositoryMock();

  final datasource = DetailsDatasourceMock();

  final getDetails = GetDetailsUsecase(datasource, repository);

  test('test if repository.getDetails() is called ', () async {
    when(() => repository.getDetails(datasource))
        .thenAnswer((invocation) async => Right(DetailsEntityMock()));

    await getDetails();
    verify(() => repository.getDetails(datasource)).called(1);
  });

  test('test if return left on error', () async {
    when(() => repository.getDetails(datasource)).thenAnswer(
        (invocation) async => Left(MediaRequestError(message: 'fake')));
    final result = await getDetails();
    expect(result, isA<Left<MediaRequestError, DetailsEntity>>());
  });

  test('test if return right on success', () async {
    when(() => repository.getDetails(datasource))
        .thenAnswer((invocation) async => Right(DetailsEntityMock()));

    final result = await getDetails();

    expect(result, isA<Right<MediaRequestError, DetailsEntity>>());
  });
}
