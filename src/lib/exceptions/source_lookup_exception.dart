import 'package:mediadrip/domain/source/source.dart';

class SourceLookupException implements Exception {
  final Source source;
  final String message;

  SourceLookupException(this.message, [this.source]);
}