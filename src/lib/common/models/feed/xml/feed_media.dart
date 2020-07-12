import 'package:mediadrip/common/models/feed/xml/index.dart';
import 'package:xml/xml.dart';

class FeedMedia {
  final String title;
  final FeedThumbnail thumbnail;
  final String description;

  /// Media that contains a [title], [thumbnail], and [description.]
  /// 
  /// The thumbnail is a [FeedThumbnail] object which contains [FeedThumbnail.url]
  FeedMedia({
    this.title,
    this.thumbnail,
    this.description
  });

  factory FeedMedia.parse(XmlElement element) {
    return FeedMedia(
      title: findElementOrNull(element, 'media:title').text,
      thumbnail: FeedThumbnail.parse(findElementOrNull(element, 'media:thumbnail')),
      description: findElementOrNull(element, 'media:description').text
    );
  }
}