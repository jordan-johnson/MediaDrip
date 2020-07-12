import 'package:mediadrip/common/models/feed/xml/index.dart';
import 'package:xml/xml.dart';

class FeedXmlModel {
  final String title;
  final List<FeedEntry> entries;

  FeedXmlModel({
    this.title,
    this.entries
  });
  
  factory FeedXmlModel.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    XmlElement feedElement;

    try {
      feedElement = document.findElements('feed').first;
    } on StateError {
      throw new ArgumentError('Feed not found in document.');
    }

    return FeedXmlModel(
      title: findElementOrNull(feedElement, 'title').text,
      entries: feedElement.findElements('entry').map((element) {
        return FeedEntry.parse(element);
      }).toList()
    );
  }
}