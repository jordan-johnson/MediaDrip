import 'package:flutter/cupertino.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/views/models/view_model.dart';
import 'package:mediadrip/common/models/feed/index.dart';

class FeedConfigViewModel extends ViewModel {
  final FeedService _feedService = locator<FeedService>();

  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController addressInputController = TextEditingController();

  FeedSourceModel _selectedFeedSource;
  FeedSourceModel get selectedFeedSource => _selectedFeedSource;
  set selectedFeedSource(FeedSourceModel value) {
    _selectedFeedSource = value;

    notifyListeners();
  }

  Map<String, String> feeds = Map<String, String>();

  FeedConfigViewModel({@required BuildContext context}) : super(context: context);

  @override
  Future<void> initialize() async {
    await updateFeeds();
  }

  Future<void> updateFeeds() async {
    this.feeds = await _feedService.getFeedsFromConfig();

    notifyListeners();
  }

  void writeNew() {
    _selectedFeedSource = null;

    nameInputController.clear();
    addressInputController.clear();

    notifyListeners();
  }

  Future<void> deleteFeed(String key) async {
    if(feeds.containsKey(key)) {
      feeds.remove(key);

      await _saveChanges();
    }
  }

  Future<bool> saveNewFeed() async {
    var interpreted = await _feedService.getInterpretedAddress(addressInputController.text);

    if(interpreted != null) {
      feeds[nameInputController.text] = interpreted;

      await _saveChanges();

      return true;
    }

    return false;
  }

  Future<void> _saveChanges() async {
    await _feedService.writeFeedsToConfig(feeds);

    notifyListeners();
  }
}