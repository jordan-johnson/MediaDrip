import 'package:mediadrip/domain/source/source.dart';

class SourceRepositoryException implements Exception {
  final Source source;
  final String message;

  SourceRepositoryException(this.message, this.source);

  @override
  String toString() => 'SourceRepositoryException: $message';
}