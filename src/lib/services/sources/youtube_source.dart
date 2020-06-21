import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/models/feed_source_model.dart';
import 'package:mediadrip/services/feed/models/feed_model.dart';

class YoutubeSource extends FeedSourceModel {
  @override
  String get sourceAddress => 'youtube.com';

  @override
  Future<List<DripModel>> parse(String content) async {
    var xml = FeedModel.parse(content);
    var drips = List<DripModel>();

    for(var entry in xml.entries) {
      var drip = DripModel(
        link: entry.link,
        title: entry.media.title,
        description: entry.media.description,
        dateTime: entry.published,
        image: Image.network(entry.media.thumbnail.url)
      );

      drips.add(drip);
    }

    return drips;
  }
}