import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/data_sources/credit_datasource.dart';
import 'package:movie_catalog/media/domain/entities/credit.dart';
import 'package:movie_catalog/media/domain/usecases/get_credits_usecase.dart';
import 'package:movie_catalog/media/infraestructure/repositories/tmdb/media_reposioty.dart';

class CreditsDatasourceMock extends Mock implements CreditDataSource {}

class CreditEntityMock extends Mock implements CreditEntity {}

void main() {
  final datasource = CreditsDatasourceMock();
  final mediaRepository = MediaRepositoryImplementation();

  test('Should call dataSource.call() ', () async {
    final getcredits = GetCreditUsecase(
      datasource,
      mediaRepository,
    );
    when(() => datasource.call())
        .thenAnswer((invocation) async => CreditEntityMock());
    await getcredits();
    verify(datasource.call).called(1);
  });
}
