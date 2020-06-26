import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';

class NetworkImageHelper {
  final String url;
  final List<String> _imageExtensions;
  final DownloadService _downloadService = locator<DownloadService>();

  NetworkImageHelper({@required this.url}) :
    _imageExtensions = ['.jpg', '.png', '.gif', '.jpeg', '.tiff', '.bmp'];

  Future<Image> get() async {
    var isImage = _imageExtensions.any((element) => this.url.contains(element));

    if(!isImage)
      return null;
    
    var content = await _downloadService.getResponseBodyAsBytes(this.url);

    if(content != null) {
      return Image.memory(content);
    }

    return null;
  }
}