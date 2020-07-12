import 'dart:convert';
import 'package:mediadrip/common/models/feed/json/index.dart';
import 'package:mediadrip/common/models/index.dart';
import 'package:mediadrip/services/sources/index.dart';
import 'package:mediadrip/utilities/index.dart';

class RedditSource extends BaseSource {
  @override
  String get display => 'Reddit';

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
  Future<String> interpret(String address) async {
    // if valid subreddit address
    if(address.contains(lookupAddresses[0]) && address.contains('\/r\/')) {
      // prepend https:// if not found
      if(!address.contains('https://')) {
        address = 'https://$address';
      }

      // append .json if not found
      if(!address.contains('.json')) {
        address += '.json';
      }

      return address;
    }

    // fail so feed won't be added
    return null;
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