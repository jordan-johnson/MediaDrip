import 'package:flutter/cupertino.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class FeedConfigViewModel extends ViewModel {
  final FeedService _feedService = locator<FeedService>();

  Map<String, String> feeds = Map<String, String>();

  FeedConfigViewModel({@required BuildContext context}) : super(context: context);

  @override
  Future<void> initialize() async {
    this.feeds = await _feedService.getFeedsFromConfig();
  }
}