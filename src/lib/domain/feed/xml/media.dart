import 'package:mediadrip/utilities/xml_helper.dart';
import 'package:xml/xml.dart';

class Media {
  final String title;
  final String description;
  final String thumbnail;

  Media({
    this.title,
    this.description,
    this.thumbnail
  });

  factory Media.parse(XmlElement element) {
    return Media(
      title: findElementOrNull(element, 'media:title')?.text,
      description: findElementOrNull(element, 'media:description')?.text,
      thumbnail: findElementOrNull(element, 'media:thumbnail')?.getAttribute('url')
    );
  }
}