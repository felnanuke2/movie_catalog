import 'package:flutter_test/flutter_test.dart';
import 'package:movie_catalog/core/model/movie_item_model.dart';

void main() {
  test(
    'Test if api return a list',
    () {
      final movies = <MovieItemModel>[];
      expect(movies, TypeMatcher<List<MovieItemModel>>());
    },
  );
}
