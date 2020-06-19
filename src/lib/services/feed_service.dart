import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed/feed_entry.dart';
import 'package:mediadrip/services/feed/feed_model.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mediadrip/utilities/date_time_helper.dart';

class FeedService {
  /// Path service used in reading and writing to feed file,
  /// [_feedListFileName], located in configuration directory, [_configDirectory].
  final PathService _pathService = locator<PathService>();

  /// Settings service used in various feed settings like max feed entries.
  final SettingsService _settingsService = locator<SettingsService>();

  /// File name for feed list.
  final String _feedListFileName = 'feed.txt';

  /// Configuration directory which is provided to [PathService] to save our 
  /// feed file.
  final AvailableDirectories _configDirectory = AvailableDirectories.configuration;

  /// Client for retrieving feed from web.
  final Client _client = http.Client();

  /// Each line in our feed file is stored here for later processing by the 
  /// xml parser.
  List<String> _addressesToRead;

  /// Complete list of feeds that will be broken down into [FeedEntry]s that 
  /// will be fed into [_allEntries] to be sorted by publishing date.
  List<FeedModel> _feeds = List<FeedModel>();

  /// All entries stripped from [_feeds] that are sorted by publishing date.
  /// 
  /// These entries will then be further sorted into [today], [yesterday], 
  /// [thisWeek], [thisMonth], and [older].
  List<FeedEntry> _allEntries = List<FeedEntry>();
  List<FeedEntry> today = List<FeedEntry>();
  List<FeedEntry> yesterday = List<FeedEntry>();
  List<FeedEntry> thisWeek = List<FeedEntry>();
  List<FeedEntry> thisMonth = List<FeedEntry>();
  List<FeedEntry> older = List<FeedEntry>();

  /// Requests the path service to check if the feed file exists, create one 
  /// if it does not, and load the contents if it does. 
  Future<void> loadFeedList() async {
    var fileExists = await _pathService.fileExistsInDirectory(_feedListFileName, _configDirectory);

    if(fileExists) {
      var file = await _pathService.getFileInDirectory(_feedListFileName, _configDirectory);

      _addressesToRead = await file.readAsLines();

      await _readAddresses();
      await _sortEntries();
    } else {
      await _pathService.createFileInDirectory(_feedListFileName, '', _configDirectory);
    }
  }

  /// Reads the addresses in [_addressesToRead] which were stored in the 
  /// [loadFeedList] method. The web client, [_client], gets the contents 
  /// from the address, and parses the XML data via [FeedModel.parse].
  /// 
  /// If the xml data parsed the contents, add the [FeedModel] to [_feeds].
  Future<void> _readAddresses() async {
    for(var address in _addressesToRead) {
      var response = await _client.get(address);
      var parser = FeedModel.parse(response.body);

      if(parser != null)
        _feeds.add(parser);
    }
  }

  /// Retrieves all feeds in [_feeds], pushes all their entries into 
  /// [_allEntries], removes any entries that exceed the max entries 
  /// setting, then sorts the entries by publishing date, and further 
  /// sorts them into [today], [yesterday], [thisWeek], [thisMonth], 
  /// and [older].
  /// 
  /// I need to refactor this to not handle multiple concerns.
  Future<void> _sortEntries() async {
    for(var feed in _feeds) {
      _allEntries.addAll(feed.entries);
    }

    // compares published dates
    _allEntries.sort((a, b) => b.published.compareTo(a.published));

    if(_allEntries.length > _settingsService.data.feedMaxEntries) {
      _allEntries.removeRange(_settingsService.data.feedMaxEntries, _allEntries.length);
    }

    for(var entry in _allEntries) {
      var published = DateTime(entry.published.year, entry.published.month, entry.published.day);

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
}