import 'package:flutter/material.dart';
import 'package:mediadrip/services/index.dart';
import 'package:mediadrip/views/models/view_model.dart';

class DownloadViewModel extends ViewModel {
  final DownloadService _downloadService = DownloadService();

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  bool _isDownloadServiceRunning = false;
  bool get isDownloadServiceRunning => _isDownloadServiceRunning;

  String get downloadButtonLabel => _isDownloadServiceRunning ? 'Wait...' : 'Download';

  DownloadViewModel({@required BuildContext context}) : super(context: context);

  Future<void> download([String address]) async {
    address = address ?? inputController.text;

    inputController.clear();

    _serviceRunning(true);

    await _downloadService.downloadUsingYoutubeDownloader(address).then((_) => _serviceRunning(false));
  }

  Future<void> update() async {
    _serviceRunning(true);

    await _downloadService.updateYoutubeDownloader().then((_) => _serviceRunning(false));
  }

  @override
  void dispose() {
    super.dispose();

    inputController.dispose();
    outputController.dispose();
  }

  // this isnt notifying listeners
  void _serviceRunning(bool running) {
    _isDownloadServiceRunning = running;

    print('test');

    notifyListeners();
  }
}