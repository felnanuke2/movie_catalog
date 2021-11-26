import 'package:movie_catalog/media/domain/entities/credit.dart';

abstract class CreditDataSource<T extends CreditEntity> {
  Future<T> call();
}
