import 'dart:core';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/feed/feed_results.dart';
import 'package:mediadrip/models/file/drip.dart';
import 'package:mediadrip/models/source/feed_source.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';

class FeedService {
  /// Path service used in reading and writing to feed file,
  /// [_feedListFileName], located in configuration directory, [_configDirectory].
  final PathService _pathService = locator<PathService>();

  /// Settings service used in various settings like max feed entries.
  final SettingsService _settingsService = locator<SettingsService>();

  /// Download service that will be used in retrieving the web feed file.
  final DownloadService _downloadService = locator<DownloadService>();

  /// File name for feed list saved in [_configDirectory].
  final String _feedListFileName = 'feed.txt';

  /// Configuration directory which is provided to [PathService] to save our 
  /// feed file.
  final AvailableDirectories _configDirectory = AvailableDirectories.configuration;

  /// List of [FeedSource] for correctly parsing the web content 
  /// via [FeedSource.parse].
  List<FeedSource> _sources = List<FeedSource>();

  /// Complete list of feeds that are mapped by name and web feed address.
  Map<String, String> feeds = Map<String, String>();

  /// All entries stripped from [feeds] that are sorted by publishing date.
  /// 
  /// These entries will then be further sorted into [today], [yesterday], 
  /// [thisWeek], [thisMonth], and [older].
  List<Drip> _entries = List<Drip>();

  /// Results from [_sortEntriesByDate] after [load] has been called.
  FeedResults results = FeedResults();

  /// Feed service is used in downloading web feeds and sorting them into 
  /// dates i.e. [today], [yesterday], [thisWeek], etc.
  /// 
  /// Refer to [load] for more information.
  FeedService();

  /// Loads web feeds from feed file saved in configuration directory.
  /// 
  /// If the file does not exist, create an empty document for later use.
  /// 
  /// Otherwise, get the file, parse its content, store the name of the 
  /// feed and address (separated by comma), order by date, remove excess 
  /// entries, and sort the entries into [today], [yesterday], [thisWeek], 
  /// [thisMonth], and [older].
  /// 
  /// An example of feeds within the feed file:
  /// 
  ///   ```text
  ///   Some Youtube Feed,https://www.youtube.com/feeds/videos.xml?channel_id=<id>
  ///   My News Feed,https://www.reddit.com/r/news.rss
  ///   ```
  /// 
  /// This method can be used to refresh the feed.
  Future<void> load() async {
    var fileExists = await _pathService.fileExistsInDirectory(_feedListFileName, _configDirectory);

    if(!fileExists) {
      await _pathService.createFileInDirectory(_feedListFileName, '', _configDirectory);

      return;
    }

    var file = await _pathService.getFileFromFileName(_feedListFileName, _configDirectory);
    var readLines = await file.readAsLines();

    // if the file exists but no feeds are entered, we're done
    if(readLines.length == 0)
      return;

    _mapFeeds(readLines);

    await _downloadFeeds();

    _orderEntriesByDateDescending();
    _removeEntriesExceedingMaxSetting();
    _sortEntriesByDate();
  }

  /// Adds a source to the collection for later use in 
  /// parsing web feeds.
  void addSource<T extends FeedSource>(T source) {
    if(source.lookupAddresses == null) {
      throw Exception('Source address cannot be empty!');
    }

    _sources.add(source);
  }

  /// Returns list of [FeedSource], found in [_sources].
  List<FeedSource> getSources() {
    return _sources;
  }

  /// Retrieves contents from feed file and returns a map of the name and address.
  Future<Map<String, String>> getFeedsFromConfig() async {
    Map<String, String> feeds = Map<String, String>();

    var file = await _pathService.getFileFromFileName(_feedListFileName, _configDirectory);
    var lines = await file.readAsLines();
    
    for(var line in lines) {
      var split = line.split(',');

      if(split == null)
        continue;

      var name = split[0];
      var address = split[1];

      if(name != null && address != null) {
        feeds[name] = address;
      }
    }

    return feeds;
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

  /// Saves a map of feeds (name, address) to file, [_feedListFileName],
  /// located in [_configDirectory].
  /// 
  /// File is always overwritten.
  /// 
  /// Once a cross-platform database solution is available, this will 
  /// be rewritten.
  Future<void> writeFeedsToConfig(Map<String, String> feeds) async {
    String contents = '';

    for(var feed in feeds.entries) {
      var interpreted = await getInterpretedAddress(feed.value);

      if(interpreted != null) {
        // comma separated with a new line
        contents += '${feed.key},$interpreted\n';
      }
    }

    await _pathService.createFileInDirectory(_feedListFileName, contents, _configDirectory);
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

  /// Map the feeds by name of the feed and its address.
  /// 
  /// The feed data will be separated by comma.
  void _mapFeeds(List<String> feedData) {
    // clear the map in case the feed is being refreshed...
    feeds.clear();

    for(var feed in feedData) {
      var split = feed.split(',');

      // make sure we have a name and address
      // if not, skip this line
      if(split.length < 2)
        continue;

      var feedName = split[0];
      var feedAddress = split[1];

      this.feeds[feedName] = feedAddress;
    }
  }

  /// Downloads the content of the web feeds and parses 
  /// the content by getting the correct source match.
  Future<void> _downloadFeeds() async {
    // clear the entries in case the feed is being refreshed...
    _entries.clear();
    results.clearAll();

    for(var feed in feeds.entries) {
      var source = getSourceByAddressLookup(feed.value);

      if(source != null) {
        var content = await _downloadService.getResponseBodyAsString(feed.value);
        var drips = await source.parse(content);

        if(drips != null) {
          _entries.addAll(drips);
        }
      }
    }
  }

  /// Speaks for itself. This method orders the entries list 
  /// from newest to oldest. This is done because the next 
  /// method will remove excess entries.
  /// 
  /// Refer to [_removeEntriesExceedingMaxSetting] for more 
  /// information.
  void _orderEntriesByDateDescending() {
    _entries.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  /// Simply removes excess entries dictated by the amount 
  /// provided by the setting.
  void _removeEntriesExceedingMaxSetting() {
    if(_entries.length > _settingsService.data.feedMaxEntries) {
      _entries.removeRange(_settingsService.data.feedMaxEntries, _entries.length);
    }
  }

  /// Sorts entries into date-categories like today, yesterday, 
  /// this week, and so on.
  void _sortEntriesByDate() {
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