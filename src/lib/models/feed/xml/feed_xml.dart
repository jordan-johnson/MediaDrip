import 'package:mediadrip/utilities/xml_helper.dart';
import 'package:xml/xml.dart';
import 'entry.dart';

class FeedXml {
  final String title;
  final List<Entry> entries;

  FeedXml({
    this.title,
    this.entries
  });

  factory FeedXml.parse(String xml) {
    var document = XmlDocument.parse(xml);

    XmlElement feedElement;

    try {
      feedElement = document.findElements('feed').first;
    } on StateError {
      throw new ArgumentError('Feed not found in document.');
    }

    return FeedXml(
      title: findElementOrNull(feedElement, 'title')?.text,
      entries: feedElement.findElements('entry').map((entry) {
        return Entry.parse(entry);
      }).toList()
    );
  }
}