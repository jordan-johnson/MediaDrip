import 'dart:convert';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/services/sources/base_source.dart';
import 'package:mediadrip/services/sources/models/reddit_json_model.dart';

class RedditSource extends BaseSource {
  @override
  String get sourceAddress => 'reddit.com';

  @override
  Future<void> download(String address) async {
    
  }

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
          entry.textContent,
          entry.created,
          entry.thumbnail
        );

        drips.add(drip);
      }
    }

    return drips;
  }
}