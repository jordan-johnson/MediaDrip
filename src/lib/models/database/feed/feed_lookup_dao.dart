import 'package:mediadrip/models/database/feed/feed_lookup.dart';

abstract class FeedLookupDao {
  List<FeedLookup> getAllFeeds();
  FeedLookup getFeedLookupById(int id);
  void insertFeedLookup(FeedLookup feed);
  void updateFeedLookup(FeedLookup feed);
  void deleteFeedLookup(FeedLookup feed);
  void deleteFeedLookupById(int id);
}