import 'package:movie_catalog/media/domain/entities/detail.dart';

abstract class DetailsDataSource<T extends DetailsEntity> {
  Future<T> call();
}
