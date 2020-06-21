import 'package:mediadrip/services/feed/models/feed_author.dart';
import 'package:mediadrip/services/feed/models/feed_entry.dart';
import 'package:mediadrip/services/feed/helper.dart';
import 'package:xml/xml.dart';

class FeedModel {
  final String title;
  final List<FeedEntry> entries;

  FeedModel({
    this.title,
    this.entries
  });
  
  factory FeedModel.parse(String xmlString) {
    var document = XmlDocument.parse(xmlString);
    XmlElement feedElement;

    try {
      feedElement = document.findElements('feed').first;
    } on StateError {
      throw new ArgumentError('Feed not found in document.');
    }

    return FeedModel(
      title: findElementOrNull(feedElement, 'title').text,
      entries: feedElement.findElements('entry').map((element) {
        return FeedEntry.parse(element);
      }).toList()
    );
  }
}