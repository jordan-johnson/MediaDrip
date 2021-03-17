import 'dart:convert';

import 'package:html/parser.dart' as htmlParser;
import 'package:mediadrip/models/feed/json/instagram_json.dart';
import 'package:mediadrip/models/file/download_instructions.dart';
import 'package:mediadrip/models/file/drip.dart';
import 'package:mediadrip/services/sources/base_source.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';

class InstagramSource extends BaseSource {
  @override
  String get display => 'Instagram';

  @override
  List<String> get lookupAddresses => [
    'instagram.com'
  ];

  @override
  DownloadInstructions configureDownload(Drip drip) {
    return DownloadInstructions(address: null, fileName: 'testing.jpg', type: DripType.image);
  }

  @override
  Future<String> interpret(String address) async {
    if(!address.contains(lookupAddresses[0]))
      return null;

    return validateAddress(address);
  }

  @override
  Future<List<Drip>> parse(String content) async {
    var drips = <Drip>[];
    var document = htmlParser.parse(content);
    var scriptTags = document.getElementsByTagName('script');
    
    String profileJsonData;

    for(var script in scriptTags) {
      if(script.text.contains('window._sharedData')) {
        profileJsonData = script.text;

        break;
      }
    }

    if(profileJsonData != null && profileJsonData.isNotEmpty) {
      profileJsonData = profileJsonData.replaceFirst('window._sharedData = ', '');
      profileJsonData = profileJsonData.substring(0, profileJsonData.lastIndexOf(';'));

      var json = jsonDecode(profileJsonData);
      var model = InstagramJson.fromJson(json);

      for(var entry in model.posts) {
        var drip = Drip(
          type: entry.isVideo ? DripType.video : DripType.image,
          link: entry.postAddress,
          isDownloadableLink: false,
          title: entry.id,
          author: model.username,
          dateTime: DateTimeHelper.unixToDateTime(entry.timestamp.toDouble()),
          thumbnail: entry.thumbnail,
          image: entry.fullSizeImage,
          description: entry.description
        );

        drips.add(drip);
      }
    }

    return drips;
  }
}