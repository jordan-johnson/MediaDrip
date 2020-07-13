import 'package:mediadrip/models/feed/ifeed_item.dart';

class FeedResults {
  final List<IFeedItem> today = List<IFeedItem>();
  final List<IFeedItem> yesterday = List<IFeedItem>();
  final List<IFeedItem> thisWeek = List<IFeedItem>();
  final List<IFeedItem> thisMonth = List<IFeedItem>();
  final List<IFeedItem> older = List<IFeedItem>();

  void clearAll() {
    today.clear();
    yesterday.clear();
    thisWeek.clear();
    thisMonth.clear();
    older.clear();
  }
}