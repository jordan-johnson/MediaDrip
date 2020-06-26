import 'package:mediadrip/common/models/download_instructions_model.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/services/feed/models/feed_model.dart';
import 'package:mediadrip/services/sources/base_source.dart';

class YoutubeSource extends BaseSource {
  @override
  List<String> get lookupAddresses => [
    'youtube.com'
  ];

  @override
  DownloadInstructionsModel configureDownload(DripModel drip) {
    print('config ${drip.link}');
    return DownloadInstructionsModel(info: drip.title, type: drip.type, address: drip.link);
  }

  @override
  Future<List<DripModel>> parse(String content) async {
    var xml = FeedModel.parse(content);
    var drips = List<DripModel>();

    for(var entry in xml.entries) {
      var drip = DripModel(
        type: DripType.video,
        link: entry.link,
        isDownloadableLink: true,
        title: entry.media.title,
        author: entry.author.name,
        description: entry.media.description,
        dateTime: entry.published,
        thumbnail: entry.media.thumbnail.url,
        image: entry.media.thumbnail.url
      );

      drips.add(drip);
    }

    return drips;
  }
}