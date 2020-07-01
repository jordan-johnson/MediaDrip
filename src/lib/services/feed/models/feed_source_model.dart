enum FeedSourceType {
  rss,
  json
}

abstract class FeedSourceModel {
  String get lookupAddress;
  FeedSourceType get type;

  void initialize();
}