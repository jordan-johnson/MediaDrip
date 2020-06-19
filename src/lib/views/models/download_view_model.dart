import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/youtube_downloader_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class DownloadViewModel extends ViewModel {
  final YoutubeDownloaderService _downloaderService = locator<YoutubeDownloaderService>();

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  bool get isDownloadServiceRunning => _downloaderService.state != DownloaderState.idle;
  String get downloadButtonLabel => isDownloadServiceRunning ? 'Wait...' : 'Download';

  DownloadViewModel({@required BuildContext context}) : super(context: context);

  void download([String address]) {
    _updateOutput('Attempting to download drip...', reset: true);

    address = address ?? inputController.text;
    inputController.clear();

    _downloaderService.download((message) => _updateOutput(message), [address]);
  }

  void update() {
    _updateOutput('Attempting to update youtube-dl...', reset: true);

    _downloaderService.update((message) => _updateOutput(message));
  }

  @override
  void dispose() {
    super.dispose();

    inputController.dispose();
    outputController.dispose();
  }

  void _updateOutput(String message, {bool reset = false}) {
    var outputControllerText = outputController.text;
    var appendTemplate = '$message\n$outputControllerText';

    message = reset ? message : appendTemplate;

    outputController.text = message;
  }
}