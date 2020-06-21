import 'package:xml/xml.dart';

class FeedThumbnail {
  final String url;

  FeedThumbnail({
    this.url
  });

  factory FeedThumbnail.parse(XmlElement element) {
    return FeedThumbnail(url: element.getAttribute('url'));
  }
}