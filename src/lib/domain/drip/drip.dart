import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediadrip/domain/feed/ifeed_item.dart';

enum DripType {
  unset,
  image,
  audio,
  video
}

class Drip implements IFeedItem {
  final String title;
  final String description;
  final String author;
  final String link;
  final DateTime dateTime;
  final DripType type;
  
  final String image;
  final String thumbnail;

  final bool isDownloadableLink;

  Drip({
    @required this.title,
    this.description,
    @required this.author,
    @required this.link,
    @required this.dateTime,
    @required this.type,
    @required this.image,
    @required this.thumbnail,
    this.isDownloadableLink
  });

  @override
  String dateTimeFormatted() {
    if(dateTime == null)
      return null;
    
    var dateFormat = DateFormat.yMMMMd('en_US').add_jm();

    return dateFormat.format(dateTime);
  }

  @override
  String toString() {
    return '${this.title} @ ${this.dateTimeFormatted()} [${this.link}]';
  }
}