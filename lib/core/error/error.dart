class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() => message.toString();
}

class Failure {
  final String message;

  const Failure(this.message);
}
