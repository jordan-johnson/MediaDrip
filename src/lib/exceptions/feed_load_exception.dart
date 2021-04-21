import 'package:mediadrip/domain/feed/feed_lookup.dart';

class FeedLoadException implements Exception {
  final FeedLookup feed;
  final String message;

  FeedLoadException(this.message, [this.feed]);

  @override
  String toString() => 'FeedLoadException: $message';
}