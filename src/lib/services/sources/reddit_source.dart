import 'dart:convert';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/models/feed_source_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/services/sources/models/reddit_json_model.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';

class RedditSource extends FeedSourceModel {
  final SettingsService _settingsService = locator<SettingsService>();

  @override
  String get sourceAddress => 'reddit.com';

  @override
  Future<List<DripModel>> parse(String content) async {
    var json = jsonDecode(content);
    var redditModel = RedditJsonModel.fromJson(json);
    var drips = List<DripModel>();

    if(redditModel != null) {
      for(var entry in redditModel.data) {
        // var drip = DripModel(
        //   title: entry.title,
        //   link: entry.url,
        //   dateTime: DateTimeHelper.unixToDateTime(entry.created),
        //   description: entry.author,
        //   image: entry.thumbnail
        // );

        var drip = await DripModel().initialize(
          entry.url,
          entry.author,
          entry.title,
          entry.author,
          entry.created,
          entry.thumbnail
        );

        drips.add(drip);
      }
    }

    return drips;
  }
}