import 'package:mediadrip/domain/feed/feed_lookup.dart';

class IFeedLookupRepository {
  Future<List<FeedLookup>> getAllFeeds() => throw Exception('Not implemented.');
  Future<void> saveFeed(FeedLookup feed) => throw Exception('Not implemented');
  Future<void> deleteFeed(FeedLookup feed) => throw Exception('Not implemented');
}