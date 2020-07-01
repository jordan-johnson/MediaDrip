import 'package:flutter/cupertino.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/utilities/image_helper.dart';
import 'package:mediadrip/views/models/view_model.dart';

class BrowseViewModel extends ViewModel {
  final DripModel drip;

  final DownloadService _downloadService = locator<DownloadService>();

  bool get isViewingMedia => drip != null;

  BrowseViewModel({@required BuildContext context, this.drip}) : super(context: context);

  @override
  Future<void> initialize() async {
    if(drip != null) {
      notifyListeners();
    }
  }

  Future<Image> getFullSizeImage() async {
    return await NetworkImageHelper(url: drip.image).get();
  }

  Future<void> downloadMedia() async {
    await _downloadService.dripToDisk(drip);
  }
}