import 'package:movie_catalog/media/domain/entities/video.dart';

abstract class VideoDataSource {
  Future<List<VideoEntity>> call();
}
