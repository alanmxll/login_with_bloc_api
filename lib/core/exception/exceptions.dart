class DatabaseException implements Exception {
  DatabaseException(this.message);

  final String message;

  @override
  String toString() => 'DatabaseException(message: $message)';
}
