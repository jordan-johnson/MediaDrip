import 'package:mediadrip/common/models/feed/xml/index.dart';
import 'package:xml/xml.dart';

class FeedAuthor {
  final String name;
  final String url;

  FeedAuthor({
    this.name,
    this.url
  });

  factory FeedAuthor.parse(XmlElement element) {
    return FeedAuthor(
      name: findElementOrNull(element, 'name')?.text,
      url: findElementOrNull(element, 'url')?.text
    );
  }
}