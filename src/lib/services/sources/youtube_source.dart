import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:mediadrip/models/feed/xml/feed_xml.dart';
import 'package:mediadrip/models/file/download_instructions.dart';
import 'package:mediadrip/models/file/drip.dart';
import 'package:mediadrip/services/sources/index.dart';

class YoutubeSource extends BaseSource {
  @override
  String get display => 'Youtube';

  @override
  List<String> get lookupAddresses => [
    'youtube.com'
  ];

  @override
  DownloadInstructions configureDownload(Drip drip) {
    return DownloadInstructions(fileName: drip.title, type: drip.type, address: drip.link);
  }

  @override
  Future<String> interpret(String address) async {
    var uri = Uri.tryParse(address);

    if(uri != null && uri.host.isNotEmpty) {
      String channelId = '';

      if(address.contains('/feeds/videos.xml?channel_id='))
        return address;

      if(address.contains('/channel/')) {
        channelId = address.split('/').last;
      } else {
        var client = http.Client();
        var response = await client.get(uri);

        if(response?.statusCode == 200) {
          var document = htmlParser.parse(response.body);
          var metaTag = document?.querySelector('meta[itemprop=\'channelId\']');

          if(metaTag != null) {
            channelId = metaTag.attributes['content'];
          }
        }
      }

      if(channelId != null && channelId.isNotEmpty) {
        return 'https://www.youtube.com/feeds/videos.xml?channel_id=$channelId';
      }
    }

    return null;
  }

  @override
  Future<List<Drip>> parse(String content) async {
    var xml = FeedXml.parse(content);
    var drips = List<Drip>();

    for(var entry in xml.entries) {
      var drip = Drip(
        type: DripType.video,
        link: entry.link,
        isDownloadableLink: true,
        title: entry.media.title,
        author: entry.author.name,
        description: entry.media.description,
        dateTime: entry.published,
        thumbnail: entry.media.thumbnail,
        image: entry.media.thumbnail
      );

      drips.add(drip);
    }

    return drips;
  }
}