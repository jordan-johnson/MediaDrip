import 'dart:convert';
import 'package:mediadrip/domain/drip/download_instructions.dart';
import 'package:mediadrip/domain/drip/drip.dart';
import 'package:mediadrip/domain/feed/json/reddit_json.dart';
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
  DownloadInstructions configureDownload(Drip drip) {
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

    return DownloadInstructions(fileName: drip.title, type: drip.type, address: address);
  }

  @override
  Future<String> interpret(String address) async {
    // if valid subreddit address
    if(address.contains(lookupAddresses[0]) && address.contains('\/r\/')) {
      address = validateAddress(address);

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
  Future<List<Drip>> parse(String content) async {
    var json = jsonDecode(content);
    var redditModel = RedditJson.fromJson(json);
    var drips = <Drip>[];

    if(redditModel != null) {
      for(var entry in redditModel.data) {
        var drip = Drip(
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

  DripType _getType(RedditJsonThreadData data) {
    if(data.isSelfText)
      return DripType.unset;
    
    if(data.isVideo)
      return DripType.video;

    return DripType.image;
  }
}