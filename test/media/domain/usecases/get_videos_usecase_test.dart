import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';
import 'package:movie_catalog/media/domain/entities/video.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';
import 'package:movie_catalog/media/domain/repositories/media_repository.dart';

import 'package:movie_catalog/media/domain/usecases/get_videos_usecase.dart';

class VideoDatasourceMock extends Mock implements VideoDataSource {}

class VideoEntityMock extends Mock implements VideoEntity {}

class MediaRepositoryMock extends Mock implements MediaRepository {}

void main() {
  final datasource = VideoDatasourceMock();
  final mediaRepository = MediaRepositoryMock();
  final getVideos = GetVideosUsecase(mediaRepository, datasource);

  test('Should call repositoy.getVideos()', () async {
    when(() => mediaRepository.getVideosList(datasource))
        .thenAnswer((invocation) async => Right([]));
    await getVideos();
    verify(() => mediaRepository.getVideosList(datasource)).called(1);
  });
  test('return left on erro  ', () async {
    when(() => mediaRepository.getVideosList(datasource)).thenAnswer(
        (invocation) async => Left(MediaRequestError(message: 'fake')));
    final result = await getVideos();
    expect(result, isA<Left<MediaRequestError, List<VideoEntity>>>());
  });

  test('return right on success ', () async {
    when(() => mediaRepository.getVideosList(datasource))
        .thenAnswer((invocation) async => Right([]));
    final result = await getVideos();

    expect(result, isA<Right<MediaRequestError, List<VideoEntity>>>());
  });
}
