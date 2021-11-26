import 'package:movie_catalog/media/domain/entities/video.dart';

abstract class VideoDataSource<T extends VideoEntity> {
  Future<List<T>> call();
}
