import 'package:flutter/cupertino.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class YoutubeConfigViewModel extends ViewModel {
  final DownloadService _downloadService = locator<DownloadService>();

  TextEditingController configurationText = TextEditingController();

  YoutubeConfigViewModel({@required BuildContext context}) : super(context: context);

  @override
  Future<void> initialize() async {
    var contents = await _downloadService.readContentsOfConfiguration();

    configurationText.text = contents;
  }

  @override
  void dispose() {
    super.dispose();

    configurationText.dispose();
  }
}