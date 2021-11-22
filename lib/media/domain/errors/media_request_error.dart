class MediaRequestError implements Exception {
  final String message;
  StackTrace? stackTrace;
  int? code;
  MediaRequestError({required this.message, this.stackTrace});
}
