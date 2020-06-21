import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';

class NetworkImageHelper {
  final String url;

  final DownloadService _downloadService = locator<DownloadService>();

  NetworkImageHelper({this.url});

  Future<Image> get() async {
    var content = await _downloadService.getBytes(this.url);

    if(content != null) {
      return Image.memory(content);
    }

    return Image.asset('lib/assets/images/image_unavailable.png');
  }
}