class SqliteNotFoundException implements Exception {
  final String message;

  SqliteNotFoundException(this.message);

  @override
  String toString() => 'SQLiteNotFoundException: $message';
}