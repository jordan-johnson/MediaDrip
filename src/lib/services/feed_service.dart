import 'dart:core';
import 'package:mediadrip/domain/drip/drip_repository.dart';
import 'package:mediadrip/domain/drip/idrip_repository.dart';
import 'package:mediadrip/domain/feed/feed_lookup.dart';
import 'package:mediadrip/domain/feed/feed_lookup_repository.dart';
import 'package:mediadrip/domain/feed/feed_results.dart';
import 'package:mediadrip/domain/feed/ifeed_lookup_repository.dart';
import 'package:mediadrip/domain/settings/isettings_repository.dart';
import 'package:mediadrip/domain/settings/settings_repository.dart';
import 'package:mediadrip/domain/source/feed_source.dart';
import 'package:mediadrip/domain/source/isource_repository.dart';
import 'package:mediadrip/domain/source/source_repository.dart';
import 'package:mediadrip/exceptions/feed_load_exception.dart';
import 'package:mediadrip/exceptions/source_lookup_exception.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';
import 'package:mediadrip/utilities/web_download_helper.dart';

class FeedService {
  final ISettingsRepository _settingsRepository = locator<SettingsRepository>();
  final ISourceRepository _sourceRepository = locator<SourceRepository>();
  final IFeedLookupRepository _lookupRepository = FeedLookupRepository();
  final IDripRepository _dripRepository = DripRepository();
  
  /// Feed service is used in downloading web feeds and sorting them into dates i.e. `today`, `yesterday`, `thisWeek`, etc.
  FeedService();

  Future<FeedResults> getResults() async {
    final lookups = await _lookupRepository.getAllFeeds();

    if(lookups == null || lookups.isEmpty)
      return FeedResults();
    
    await _initializeSourceLookupMatching(lookups);

    return await _processDrips();
  }

  Future<void> _initializeSourceLookupMatching(List<FeedLookup> lookups) async {
    for(var lookup in lookups) {
      final source = _sourceRepository.getFeedSourceByAddressLookup(lookup.address);

      if(source != null) {
        _downloadFeedLookup(source, lookup);
      } else {
        throw SourceLookupException('Source lookup failed for ${lookup.address}. This usually means the feed is not supported');
      }
    }
  }

  Future<void> _downloadFeedLookup(FeedSource source, FeedLookup lookup) async {
    try {
      final content = await WebDownloadHelper.getResponseBodyAsString(lookup.address);
      final drips = await source.parse(content);

      if(drips != null) {
        _dripRepository.addDrips(drips);
      }
    } catch(e) {
      throw FeedLoadException('${lookup.label} could not be loaded. If problem persists, delete the feed from settings.', lookup);
    }
  }

  Future<FeedResults> _processDrips() async {
    if(_dripRepository.count() == 0)
      return FeedResults();

    final maxEntries = await _settingsRepository.getSettings().then((x) => x.feedMaxEntries);

    _dripRepository.orderDripsByDateDescending();
    _dripRepository.removeDripsExceedingMaxCount(maxEntries);

    return await _buildResults();
  }

  Future<FeedResults> _buildResults() async {
    FeedResults results = FeedResults();

    if(_dripRepository.count() == 0)
      return results;

    for(var drip in _dripRepository.getAllDrips()) {
      var published = DateTime(drip.dateTime.year, drip.dateTime.month, drip.dateTime.day);
      
      if(DateTimeHelper.isToday(published)) {
        results.today.add(drip);
      } else if(DateTimeHelper.isYesterday(published)) {
        results.yesterday.add(drip);
      } else if(DateTimeHelper.isWithinDaysFromNow(published, 2, 7)) {
        results.thisWeek.add(drip);
      } else if(DateTimeHelper.isWithinDaysFromNow(published, 2, 30)) {
        results.thisMonth.add(drip);
      } else {
        results.older.add(drip);
      }
    }

    return results;
  }
}