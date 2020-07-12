import 'package:mediadrip/common/models/feed/xml/index.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

class FeedEntry {
  String link;
  FeedAuthor author;
  DateTime published;
  FeedMedia media;

  /// A media entry which contains the [link], date the entry was [published],
  /// and the [media] which is an [FeedMedia] object.
  FeedEntry({
    this.link,
    this.author,
    this.published,
    this.media
  });

  factory FeedEntry.parse(XmlElement element) {
    return FeedEntry(
      link: findElementOrNull(element, 'link')?.getAttribute('href'),
      author: FeedAuthor.parse(findElementOrNull(element, 'author')),
      published: DateTime.parse(findElementOrNull(element, 'published')?.text),
      media: FeedMedia.parse(element)
    );
  }

  /// this will eventually be removed/refactored to a general 
  /// media object for the rest of the app to use
  List<String> modelToCollection() {
    // formats DateTime i.e. June 18, 2020
    var dateFormat = DateFormat.yMMMMd('en_US').add_jm();

    return [
      this.link,
      this.media.title,
      this.media.description,
      (this.published != null) ? dateFormat.format(this.published) : '',
      this.media.thumbnail.url
    ];
  }
}