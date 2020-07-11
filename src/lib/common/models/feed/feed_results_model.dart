import 'package:mediadrip/common/models/feed/index.dart';

class FeedResultsModel {
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