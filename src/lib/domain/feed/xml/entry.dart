import 'package:mediadrip/domain/feed/xml/author.dart';
import 'package:mediadrip/domain/feed/xml/media.dart';
import 'package:mediadrip/utilities/xml_helper.dart';
import 'package:xml/xml.dart';

class Entry {
  final String link;
  final Author author;
  final DateTime published;
  final Media media;

  Entry({
    this.link,
    this.author,
    this.published,
    this.media
  });

  factory Entry.parse(XmlElement element) {
    return Entry(
      link: findElementOrNull(element, 'link')?.getAttribute('href'),
      author: Author.parse(findElementOrNull(element, 'author')),
      published: DateTime.parse(findElementOrNull(element, 'published')?.text),
      media: Media.parse(element)
    );
  }
}