import 'package:flutter/cupertino.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class BrowseViewModel extends ViewModel {
  final Object arguments;

  final DownloadService _youtubeDownloaderService = locator<DownloadService>();

  bool get isViewingMedia => arguments != null;

  DripModel currentDrip;

  BrowseViewModel({@required BuildContext context, this.arguments}) : super(context: context);

  @override
  Future<void> initialize() async {
    if(arguments != null) {
      if(arguments is DripModel) {
        currentDrip = arguments;

        notifyListeners();
      }
    }
  }

  Future<void> downloadMedia() async {
    // await _youtubeDownloaderService.download((_) => null, [currentDrip.link]);
  }
}