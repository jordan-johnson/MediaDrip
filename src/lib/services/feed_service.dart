import 'dart:core';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/models/feed_source_model.dart';
import 'package:mediadrip/locator.dart';
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

  /// List of [FeedSourceModel] for correctly parsing the web content 
  /// via [FeedSourceModel.parse].
  List<FeedSourceModel> _sources = List<FeedSourceModel>();

  /// Complete list of feeds that are mapped by name and web feed address.
  Map<String, String> feeds = Map<String, String>();

  /// All entries stripped from [feeds] that are sorted by publishing date.
  /// 
  /// These entries will then be further sorted into [today], [yesterday], 
  /// [thisWeek], [thisMonth], and [older].
  List<DripModel> _entries = List<DripModel>();
  List<DripModel> today = List<DripModel>();
  List<DripModel> yesterday = List<DripModel>();
  List<DripModel> thisWeek = List<DripModel>();
  List<DripModel> thisMonth = List<DripModel>();
  List<DripModel> older = List<DripModel>();

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

    if(!fileExists)
      return await _pathService.createFileInDirectory(_feedListFileName, '', _configDirectory);

    var file = await _pathService.getFileInDirectory(_feedListFileName, _configDirectory);
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
  void addSource<T extends FeedSourceModel>(T source) {
    if(source.sourceAddress.isEmpty) {
      throw Exception('Source address cannot be empty!');
    }

    _sources.add(source);
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

    for(var feed in feeds.entries) {
      var source = _getSourceByAddress(feed.value);

      if(source != null) {
        var content = await _downloadService.get(feed.value);
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
        today.add(entry);
      } else if(DateTimeHelper.isYesterday(published)) {
        yesterday.add(entry);
      } else if(DateTimeHelper.isWithinDaysFromNow(published, 2, 7)) {
        thisWeek.add(entry);
      } else if(DateTimeHelper.isWithinDaysFromNow(published, 2, 30)) {
        thisMonth.add(entry);
      } else {
        older.add(entry);
      }
    }
  }

  /// Get a feed source by checking if the [address] contains 
  /// the base URL.
  /// 
  /// For example, a Youtube source will use youtube.com as the 
  /// sourceAddress property. The [address] parameter in this 
  /// is checked if it contains youtube.com
  FeedSourceModel _getSourceByAddress(String address) {
    return _sources.firstWhere((x) => address.contains(x.sourceAddress), orElse: () => null);
  }
}