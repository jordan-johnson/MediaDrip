import 'package:flutter/cupertino.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/youtube_downloader_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class BrowseViewModel extends ViewModel {
  final List<String> arguments;

  final YoutubeDownloaderService _youtubeDownloaderService = locator<YoutubeDownloaderService>();

  bool get isViewingMedia => arguments != null && arguments.length > 0;

  String _mediaLink;
  String get mediaLink => _mediaLink;

  String _mediaTitle;
  String get mediaTitle => _mediaTitle;

  String _mediaDescription;
  String get mediaDescription => _mediaDescription;

  String _mediaDate;
  String get mediaDate => _mediaDate;

  String _mediaThumbnail;
  String get mediaThumbnail => _mediaThumbnail;

  BrowseViewModel({@required BuildContext context, this.arguments}) : super(context: context);

  @override
  Future<void> initialize() async {
    if(arguments != null) {
      _mediaLink = arguments[0];
      _mediaTitle = arguments[1];
      _mediaDescription = arguments[2];
      _mediaDate = arguments[3];
      _mediaThumbnail = arguments[4];

      notifyListeners();
    }
  }

  Future<void> downloadMedia() async {
    await _youtubeDownloaderService.download((_) => null, [_mediaLink]);
  }
}