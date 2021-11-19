class AuthUnauthenticatedError implements Exception {
  final String message;
  AuthUnauthenticatedError({
    required this.message,
  });
}
