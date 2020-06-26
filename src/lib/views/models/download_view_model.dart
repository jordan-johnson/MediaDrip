import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class DownloadViewModel extends ViewModel {
  final DownloadService _downloaderService = locator<DownloadService>();

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  bool get isDownloadServiceRunning => false;
  String get downloadButtonLabel => isDownloadServiceRunning ? 'Wait...' : 'Download';

  DownloadViewModel({@required BuildContext context}) : super(context: context);

  void download([String address]) {
    _updateOutput('Attempting to download drip...', reset: true);

    address = address ?? inputController.text;
    inputController.clear();

    // _downloaderService
  }

  void update() {
    _updateOutput('Attempting to update youtube-dl...', reset: true);

    // _downloaderService.update((message) => _updateOutput(message));
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