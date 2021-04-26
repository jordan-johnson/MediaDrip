import 'package:mediadrip/domain/source/download_source.dart';
import 'package:mediadrip/domain/source/feed_source.dart';
import 'package:mediadrip/domain/source/source.dart';

class ISourceRepository {
  void addSource(Source source) => throw Exception('Not implemented.');
  void addFeedSource(FeedSource source) => throw Exception('Not implemented.');
  void addDownloadSource(DownloadSource source) => throw Exception('Not implemented.');

  FeedSource getFeedSourceByAddressLookup(String address) => throw Exception('Not implemented.');
  DownloadSource getDownloadSourceByAddressLookup(String address) => throw Exception('Not implemented.');
}