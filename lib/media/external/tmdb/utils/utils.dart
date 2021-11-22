import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_catalog/media/domain/errors/media_request_error.dart';

class TmdbUtils {
  TmdbUtils._();
  static throwError(Response request) {
    switch (request.statusCode) {
      case 401:
        final json = jsonDecode(request.body);
        final errorMessage = json['status_message'];
        throw MediaRequestError(message: errorMessage)
          ..code = json['status_code'];

      case 404:
        final json = jsonDecode(request.body);
        final errorMessage = json['status_message'];
        throw MediaRequestError(message: errorMessage)
          ..code = json['status_code'];
      default:
    }
  }
}
