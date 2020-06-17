import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed/feed_entry.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/views/models/view_model.dart';

class HomeViewModel extends ViewModel {
  final FeedService _feedService;
  final int gridCount = 3;
  
  bool _loading = false;
  bool get loading => _loading;

  List<FeedEntry> get today => _feedService.today;
  List<FeedEntry> get yesterday => _feedService.yesterday;
  List<FeedEntry> get thisWeek => _feedService.thisWeek;
  List<FeedEntry> get thisMonth => _feedService.thisMonth;
  List<FeedEntry> get older => _feedService.older;

  HomeViewModel({@required BuildContext context}) : 
    _feedService = locator<FeedService>(),
    super(context: context);

  @override
  Future<void> initialize() async {
    _setLoading(true);

    await _feedService.loadFeedList();

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _loading = value;

    notifyListeners();
  }
}