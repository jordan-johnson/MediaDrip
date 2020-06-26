import 'package:flutter/cupertino.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/utilities/image_helper.dart';
import 'package:mediadrip/views/models/view_model.dart';

class BrowseViewModel extends ViewModel {
  final Object arguments;

  final DownloadService _downloadService = locator<DownloadService>();

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

  Future<Image> getFullSizeImage() async {
    return await NetworkImageHelper(url: currentDrip.image).get();
  }

  Future<void> downloadMedia() async {
    await _downloadService.dripToDisk(currentDrip);
  }
}