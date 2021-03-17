import 'package:mediadrip/models/feed/ifeed_item.dart';

class FeedResults {
  final List<IFeedItem> today = <IFeedItem>[];
  final List<IFeedItem> yesterday = <IFeedItem>[];
  final List<IFeedItem> thisWeek = <IFeedItem>[];
  final List<IFeedItem> thisMonth = <IFeedItem>[];
  final List<IFeedItem> older = <IFeedItem>[];

  void clearAll() {
    today.clear();
    yesterday.clear();
    thisWeek.clear();
    thisMonth.clear();
    older.clear();
  }
}