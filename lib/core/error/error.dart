class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}

class Failure {
  final String message;

  const Failure(this.message);
}
