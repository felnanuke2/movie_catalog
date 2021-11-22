import 'package:movie_catalog/media/domain/entities/person.dart';

class CreditEntity {
  final String id;
  final List<PersonEntity> cast;
  final List<PersonEntity> crew;
  CreditEntity({
    required this.id,
    required this.crew,
    required this.cast,
  });
}
