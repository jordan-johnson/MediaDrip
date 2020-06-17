import 'dart:io';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed/feed_entry.dart';
import 'package:mediadrip/services/feed/feed_model.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mediadrip/utilities/date_time_helper.dart';
import 'package:xml/xml.dart';

class FeedService {
  final PathService _pathService = locator<PathService>();
  final SettingsService _settingsService = locator<SettingsService>();

  final String _feedListFileName = 'feed.txt';
  final AvailableDirectories _configDirectory = AvailableDirectories.configuration;

  final Client _client = http.Client();

  List<String> _addressesToRead;
  List<FeedModel> _feeds = List<FeedModel>();

  List<FeedEntry> _allEntries = List<FeedEntry>();
  List<FeedEntry> today = List<FeedEntry>();
  List<FeedEntry> yesterday = List<FeedEntry>();
  List<FeedEntry> thisWeek = List<FeedEntry>();
  List<FeedEntry> thisMonth = List<FeedEntry>();
  List<FeedEntry> older = List<FeedEntry>();

  Future<void> loadFeedList() async {
    var fileExists = await _pathService.fileExistsInDirectory(_feedListFileName, _configDirectory);

    if(fileExists) {
      var file = await _pathService.getFileInDirectory(_feedListFileName, _configDirectory);

      _addressesToRead = await file.readAsLines();

      await _readAddresses();
      await _sortEntries();
    } else {
      await saveFeed();
    }
  }

  Future<void> saveFeed() async {
    await _pathService.createFileInDirectory(_feedListFileName, '', _configDirectory);
  }

  Future<void> _readAddresses() async {
    for(var address in _addressesToRead) {
      var response = await _client.get(address);
      var parser = FeedModel.parse(response.body);

      if(parser != null)
        _feeds.add(parser);
    }
  }

  Future<void> _sortEntries() async {
    for(var feed in _feeds) {
      _allEntries.addAll(feed.entries);

      if(_allEntries.length > _settingsService.data.feedMaxEntries) {
        _allEntries.removeRange(_settingsService.data.feedMaxEntries, _allEntries.length);
      }
    }

    // compares published dates
    _allEntries.sort((a, b) => b.published.compareTo(a.published));

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