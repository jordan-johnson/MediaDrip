import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/drip_header.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _DownloadViewModel extends WidgetModel {
  final DownloadService _downloadService = locator<DownloadService>();

  final TextEditingController inputController = TextEditingController();
  
  bool _isDownloadServiceRunning = false;
  bool get isDownloadServiceRunning => _isDownloadServiceRunning;

  String get downloadButtonLabel => _isDownloadServiceRunning ? 'Wait...' : 'Download';

  _DownloadViewModel({@required BuildContext context}) : super(context: context);

  Future<void> download([String address]) async {
    address = address ?? inputController.text;

    inputController.clear();

    isDownloadServiceRunning = true;

    await _downloadService.downloadUsingYoutubeDownloader(address);

    isDownloadServiceRunning = false;
  }

  Future<void> update() async {
    isDownloadServiceRunning = true;

    await _downloadService.updateYoutubeDownloader();

    isDownloadServiceRunning = false;
  }

  set isDownloadServiceRunning(bool value) {
    _isDownloadServiceRunning = value;

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    inputController.dispose();
  }
}

class DownloadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_DownloadViewModel>(
      model: _DownloadViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'Download',
          route: Routes.download,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DripHeader(
                        icon: Icons.arrow_downward,
                        header: 'Let\'s start dripping.',
                        subHeader: 'Downloading without issue requires both ffmpeg and youtube-dl to be installed and added to your system variables.'
                      ),
                      TextFormField(
                        controller: model.inputController,
                        decoration: InputDecoration(
                          hintText: 'Please enter a URL...'
                        ),
                        onFieldSubmitted: (value) => model.download(value),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.autorenew),
                              iconSize: 24,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async => await model.update(),
                            ),
                            TextButton(
                              child: Text(model.downloadButtonLabel),
                              onPressed: model.isDownloadServiceRunning ? null : () => model.download(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ],
            )
          ),
        );
      },
    );
  }
}