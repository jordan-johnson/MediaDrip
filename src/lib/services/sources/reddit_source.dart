import 'dart:convert';
import 'package:mediadrip/common/models/download_instructions_model.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/services/sources/base_source.dart';
import 'package:mediadrip/services/sources/models/reddit_json_model.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';

class RedditSource extends BaseSource {
  @override
  List<String> get lookupAddresses => [
    'reddit.com',
    'i.redd.it',
    'v.redd.it',
    'i.imgur.com',
  ];

  @override
  DownloadInstructionsModel configureDownload(DripModel drip) {
    String address;

    switch(drip.type) {
      case DripType.image:
        address = drip.image;
      break;
      case DripType.audio:
      case DripType.video:
      default:
        address = drip.link;
      break;
    }

    return DownloadInstructionsModel(info: drip.title, type: drip.type, address: address);
  }

  @override
  Future<List<DripModel>> parse(String content) async {
    var json = jsonDecode(content);
    var redditModel = RedditJsonModel.fromJson(json);
    var drips = List<DripModel>();

    if(redditModel != null) {
      for(var entry in redditModel.data) {
        var drip = DripModel(
          type: _getType(entry),
          link: entry.url,
          isDownloadableLink: !entry.isSelfText,
          title: entry.title,
          author: entry.author,
          dateTime: DateTimeHelper.unixToDateTime(entry.created),
          thumbnail: entry.thumbnail,
          image: (!entry.isVideo && !entry.isSelfText) ? entry.url : entry.thumbnail,
          description: entry.textContent
        );

        drips.add(drip);
      }
    }

    return drips;
  }

  DripType _getType(RedditJsonDataModel data) {
    if(data.isSelfText)
      return DripType.unset;
    
    if(data.isVideo)
      return DripType.video;

    return DripType.image;
  }
}