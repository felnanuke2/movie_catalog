import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_catalog/media/domain/data_sources/video_data_source.dart';

import 'package:movie_catalog/media/domain/usecases/get_videos_usecase.dart';
import 'package:movie_catalog/media/infraestructure/repositories/tmdb/media_reposioty.dart';

class VideoDatasourceMock extends Mock implements VideoDataSource {}

void main() {
  final videoDatasourceMock = VideoDatasourceMock();
  final mediaRepository = MediaRepositoryImplementation();

  test('Should call datasource.call() ', () async {
    final getVideo = GetVideosUsecase(mediaRepository, videoDatasourceMock);
    when(() => videoDatasourceMock.call()).thenAnswer((invocation) async => []);
    await getVideo();
    verify(videoDatasourceMock.call).called(1);
  });
}
