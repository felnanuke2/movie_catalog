import 'package:movie_catalog/media/domain/entities/credit.dart';

abstract class CreditDataSource {
  Future<CreditEntity> call();
}
