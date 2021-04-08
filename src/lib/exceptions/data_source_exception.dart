class DataSourceException implements Exception {
  final String message;
  
  DataSourceException(this.message);

  @override
  String toString() => 'DataSourceException: $message';
}