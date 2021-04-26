import 'package:mediadrip/utilities/xml_helper.dart';
import 'package:xml/xml.dart';

class Author {
  final String name;
  final String url;

  Author({
    this.name,
    this.url
  });

  factory Author.parse(XmlElement element) {
    return Author(
      name: findElementOrNull(element, 'name')?.text,
      url: findElementOrNull(element, 'url')?.text
    );
  }
}