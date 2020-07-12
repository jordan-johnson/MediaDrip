import 'package:xml/xml.dart';

class FeedLink {
  final String href;

  FeedLink({
    this.href
  });

  factory FeedLink.parse(XmlElement element) {
    return FeedLink(href: element.getAttribute('href'));
  }
}