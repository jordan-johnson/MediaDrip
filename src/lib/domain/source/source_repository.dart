import 'package:mediadrip/domain/source/download_source.dart';
import 'package:mediadrip/domain/source/feed_source.dart';
import 'package:mediadrip/domain/source/isource_repository.dart';
import 'package:mediadrip/domain/source/source.dart';
import 'package:mediadrip/exceptions/source_repository_exception.dart';

class SourceRepository implements ISourceRepository {
  List<FeedSource> _feedSources = <FeedSource>[];
  List<DownloadSource> _downloadSources = <DownloadSource>[];

  // Adds a source to both feed and download source containers.
  void addSource(Source source) {
    addFeedSource(source);
    addDownloadSource(source);
  }

  /// Adds a source to the collection for later use in parsing web feeds.
  void addFeedSource(FeedSource source) {
    if(source.lookupAddresses == null) {
      throw SourceRepositoryException('Feed source lookup address null.', source);
    }

    _feedSources.add(source);
  }

  /// Get a feed source by checking if the [address] contains the base URL.
  /// 
  /// For example, a Youtube source will use youtube.com as a lookup address. The 
  /// [address] parameter is used to check for a match with the lookup.
  /// 
  /// A source can contain multiple lookup addresses.
  FeedSource getFeedSourceByAddressLookup(String address) {
    for(var source in _feedSources) {
      if(source.doesAddressExistInLookup(address)) {
        return source;
      }
    }

    return null;
  }

  /// Adds a source to the collection for later use in downloading media.
  void addDownloadSource(DownloadSource source) {
    if(source.lookupAddresses == null) {
      throw SourceRepositoryException('Download source lookup address null.', source);
    }

    _downloadSources.add(source);
  }

  /// Get a download source by checking if the [address] contains the base URL.
  /// 
  /// For example, a Youtube source will use youtube.com as a lookup address. The 
  /// [address] parameter is used to check for a match with the lookup.
  /// 
  /// A source can contain multiple lookup addresses.
  DownloadSource getDownloadSourceByAddressLookup(String address) {
    for(var source in _downloadSources) {
      if(source.doesAddressExistInLookup(address)) {
        return source;
      }
    }

    return null;
  }
}