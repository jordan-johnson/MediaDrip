import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/feed/index.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class HomeViewModel extends ViewModel {
  final FeedService _feedService;

  HomeViewModel({@required BuildContext context}) : 
    _feedService = locator<FeedService>(),
    super(context: context);

  Future<FeedResultsModel> getFeed() async {
    await _feedService.load();
    
    return _feedService.results;
  }
}