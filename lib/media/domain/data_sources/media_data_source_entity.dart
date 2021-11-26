import 'package:movie_catalog/media/domain/entities/media.dart';

abstract class MediaDataSource<T extends MediaEntity> {
  Future<List<T>> call();
}
