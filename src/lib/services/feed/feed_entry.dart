import 'package:mediadrip/services/feed/feed_media.dart';
import 'package:mediadrip/services/feed/helper.dart';
import 'package:xml/xml.dart';

class FeedEntry {
  String link;
  DateTime published;
  FeedMedia media;

  /// A media entry which contains the [link], date the entry was [published],
  /// and the [media] which is an [FeedMedia] object.
  FeedEntry({
    this.link,
    this.published,
    this.media
  });

  factory FeedEntry.parse(XmlElement element) {
    return FeedEntry(
      link: findElementOrNull(element, 'link')?.text,
      published: DateTime.parse(findElementOrNull(element, 'published').text),
      media: FeedMedia.parse(element)
    );
  }
}