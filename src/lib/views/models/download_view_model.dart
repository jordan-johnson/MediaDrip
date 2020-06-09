import 'package:flutter/material.dart';
import 'package:mediadrip/services/youtube_downloader_service.dart';

class DownloadViewModel extends ChangeNotifier {
  final YoutubeDownloaderService _downloaderService = YoutubeDownloaderService();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  bool get isDownloadServiceRunning => _downloaderService.state != DownloaderState.idle;
  String get downloadButtonLabel => isDownloadServiceRunning ? 'Wait...' : 'Download';

  void download([String address]) {
    address = address ?? inputController.text;

    inputController.clear();
  }

  void update() {

  }
}