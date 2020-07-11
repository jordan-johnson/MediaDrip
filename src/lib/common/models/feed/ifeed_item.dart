import 'package:flutter/material.dart';

class IFeedItem {
  final String link;
  final String author;
  final String title;
  final String description;
  final String thumbnail;
  final String image;
  final DateTime dateTime;

  IFeedItem({
    @required this.link,
    @required this.author,
    @required this.title,
    @required this.thumbnail,
    @required this.image,
    @required this.dateTime,
    this.description
  });

  String dateTimeFormatted() {
    return 'N/A';
  }
}