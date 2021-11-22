import 'package:movie_catalog/media/domain/entities/media.dart';

abstract class MediaDataSource {
  Future<List<MediaEntity>> call();
}
