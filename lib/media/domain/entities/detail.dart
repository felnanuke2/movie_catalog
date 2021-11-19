import 'package:movie_catalog/media/domain/entities/genre.dart';

class DetailsEntity {
  final String id;
  final String posterPath;
  final num voteAverage;
  final List<GenreEntity> genres;
  DetailsEntity({
    required this.id,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
  });
}
