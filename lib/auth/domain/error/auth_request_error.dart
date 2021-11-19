class AuthRequestError implements Exception {
  final String message;
  AuthRequestError({
    required this.message,
  });
}
