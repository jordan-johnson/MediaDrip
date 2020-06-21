import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediadrip/utilities/date_time_helper.dart';
import 'package:mediadrip/utilities/image_helper.dart';

class DripModel {
  String link;
  String author;
  String title;
  String description;
  DateTime dateTime;
  String dateTimeFormatted;
  Image image;

  Future<DripModel> initialize(String link, String author, String title, String description, dynamic dateTime, String image) async {
    this.link = link;
    this.author = author;
    this.title = title;
    this.description = description;
    this.dateTime = (dateTime is double) ? DateTimeHelper.unixToDateTime(dateTime) : dateTime;
    this.dateTimeFormatted = _formatDateTime(this.dateTime);
    this.image = await NetworkImageHelper(url: image).get();

    return this;
  }

  String _formatDateTime(DateTime dateTime) {
    var dateFormat = DateFormat.yMMMMd('en_US').add_jm();

    return dateFormat.format(dateTime);
  }

  @override
  String toString() {
    return '${this.title} @ ${this.dateTimeFormatted} [${this.link}]';
  }
}