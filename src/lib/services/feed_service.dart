import 'dart:core';
import 'package:mediadrip/domain/drip/drip.dart';
import 'package:mediadrip/domain/feed/feed_lookup.dart';
import 'package:mediadrip/domain/feed/feed_results.dart';
import 'package:mediadrip/domain/source/feed_source.dart';
import 'package:mediadrip/exceptions/feed_load_exception.dart';
import 'package:mediadrip/exceptions/source_lookup_exception.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/database/data_source.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';
import 'package:sqlite3/sqlite3.dart';

class FeedService {
  final SettingsService _settingsService = locator<SettingsService>();
  final DataSource<Database> _dataSource = locator<SqliteDatabase>();

  final DownloadService _downloadService = locator<DownloadService>();

  /// Matching table name within SQLite database.
  final String _tableName = 'feed_lookup';

  /// List of [FeedSource] for correctly parsing the web content 
  /// via [FeedSource.parse].
  List<FeedSource> _sources = <FeedSource>[];

  /// All unsorted entries from web feeds. Once sorted, the [Drip]s wil be 
  /// placed in [results].
  List<Drip> _entries = <Drip>[];

  /// Ordered web feed entries.
  FeedResults results = FeedResults();
  
  /// Feed service is used in downloading web feeds and sorting them into 
  /// dates i.e. `today`, `yesterday`, `thisWeek`, etc.
  FeedService();

  /// Adds a source to the collection for later use in 
  /// parsing web feeds.
  void addSource<T extends FeedSource>(T source) {
    if(source.lookupAddresses == null) {
      throw Exception('Source address cannot be empty!');
    }

    _sources.add(source);
  }

  List<FeedSource> getSources() {
    return _sources;
  }

  Future<List<FeedLookup>> getAllFeeds() async {
    return await _dataSource.retrieve<List<FeedLookup>>((source) {
      final results = source.select('SELECT * FROM $_tableName');

      List<FeedLookup> feeds = <FeedLookup>[];

      for(final row in results) {
        final feed = FeedLookup.fromMap(row);

        feeds.add(feed);
      }

      return feeds;
    });
  }

  /// Loads web feeds from database.
  /// 
  /// Gets the feeds, downloads them using [DownloadService], orders the 
  /// entries by date, and removes excess entries based on setting.
  /// 
  /// This method can be used to refresh the feed.
  Future<void> load() async {
    final feeds = await getAllFeeds();

    if(feeds == null || feeds.isEmpty)
      return;

    await _downloadFeeds(feeds);

    _orderEntriesByDateDescending();
    _removeEntriesExceedingMaxSetting();
    _sortEntriesByDate();
  }

  /// Downloads the content of the web feeds and parses the content by 
  /// getting the correct source match.
  Future<void> _downloadFeeds(List<FeedLookup> feeds) async {
    // clear the entries in case the feed is being refreshed...
    _entries.clear();
    results.clearAll();

    if(feeds == null || feeds.isEmpty)
      return;

    for(var feed in feeds) {
      var source = getSourceByAddressLookup(feed.address);

      if(source != null) {
        try {
          var content = await _downloadService.getResponseBodyAsString(feed.address);
          var drips = await source.parse(content);

          if(drips != null) {
            _entries.addAll(drips);
          }
        } catch(e) {
          throw FeedLoadException('Feed, ${feed.label}, could not be loaded. If problem persists, delete the feed from settings.', feed);
        }
      } else {
        throw SourceLookupException('Source lookup failed for ${feed.address}. This usually means the feed you added is not supported.');
      }
    }
  }

  /// Get a feed source by checking if the [address] contains 
  /// the base URL.
  /// 
  /// For example, a Youtube source will use youtube.com as the 
  /// sourceAddress property. The [address] parameter in this 
  /// is checked if it contains youtube.com
  FeedSource getSourceByAddressLookup(String address) {
    for(var source in _sources) {
      for(var lookup in source.lookupAddresses) {
        if(address.contains(lookup)) {
          return source;
        }
      }
    }

    return null;
  }

  /// Does a source lookup based on [address] and returns the 
  /// interpreted address.
  /// 
  /// Refer to [FeedSourceModel] for more information.
  Future<String> getInterpretedAddress(String address) async {
    var sourceLookup = getSourceByAddressLookup(address);

    if(sourceLookup != null) {
      var interpreted = await sourceLookup.interpret(address);

      if(interpreted != null) {
        return interpreted;
      }
    }

    return null;
  }

  /// Speaks for itself. This method orders the entries list 
  /// from newest to oldest. This is done because the next 
  /// method will remove excess entries.
  /// 
  /// Refer to [_removeEntriesExceedingMaxSetting] for more 
  /// information.
  void _orderEntriesByDateDescending() {
    if(_entries == null || _entries.isEmpty)
      return;

    _entries.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  /// Simply removes excess entries dictated by the amount 
  /// provided by the setting.
  void _removeEntriesExceedingMaxSetting() {
    if(_entries == null || _entries.isEmpty || _settingsService.data == null)
      return;

    print('entry length: ${_entries.length} -- ${_settingsService.data.feedMaxEntries}');

    if(_entries.length > _settingsService?.data?.feedMaxEntries) {
      _entries.removeRange(_settingsService.data.feedMaxEntries, _entries.length);
    }
  }

  /// Sorts entries into date-categories like today, yesterday, 
  /// this week, and so on.
  void _sortEntriesByDate() {
    if(_entries == null || _entries.isEmpty)
      return;

    for(var entry in _entries) {
      var published = DateTime(entry.dateTime.year, entry.dateTime.month, entry.dateTime.day);

      if(DateTimeHelper.isToday(published)) {
        results.today.add(entry);
      } else if(DateTimeHelper.isYesterday(published)) {
        results.yesterday.add(entry);
      } else if(DateTimeHelper.isWithinDaysFromNow(published, 2, 7)) {
        results.thisWeek.add(entry);
      } else if(DateTimeHelper.isWithinDaysFromNow(published, 2, 30)) {
        results.thisMonth.add(entry);
      } else {
        results.older.add(entry);
      }
    }
  }
}