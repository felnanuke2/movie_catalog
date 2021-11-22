import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/data_sources/media_data_source_entity.dart';
import 'package:movie_catalog/media/domain/entities/media.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/usecases/get_media_usecase.dart';

import 'get_videos_usecase_test.dart';

class MediaDataSourceMock extends Mock implements MediaDataSource {}

void main() {
  final datasource = MediaDataSourceMock();
  final repository = MediaRepositoryMock();
  final getMedia = GetMediaUsecase(datasource, repository);
  test('test if repository.getMedia() is called', () async {
    when(() => repository.getMedia(datasource))
        .thenAnswer((invocation) async => Right([]));
    await getMedia();
    verify(() => repository.getMedia(datasource)).called(1);
  });

  test('test if return left on error', () async {
    when(() => repository.getMedia(datasource)).thenAnswer(
        (invocation) async => Left(MediaRequestError(message: 'fake')));
    final result = await getMedia();
    expect(result, isA<Left<MediaRequestError, List<MediaEntity>>>());
  });

  test('test if return rigth on success ', () async {
    when(() => repository.getMedia(datasource))
        .thenAnswer((invocation) async => Right([]));
    final result = await getMedia();
    expect(result, isA<Right<MediaRequestError, List<MediaEntity>>>());
  });
}
