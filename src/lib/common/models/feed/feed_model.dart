import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/feed/index.dart';
import 'package:mediadrip/common/models/widget_model.dart';

class FeedModel extends WidgetModel {
  final Future<FeedResultsModel> future;
  final Widget Function(BuildContext context, IFeedItem entry) itemBuilder;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FeedResultsModel results = FeedResultsModel();

  FeedModel({
    @required BuildContext context,
    @required this.future,
    @required this.itemBuilder
  }) : super(context: context);

  @override
  Future<void> initialize() async {
    await refresh();
  }

  Future<void> refresh() async {
    _setLoading(true);

    results = await this.future;

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    
    notifyListeners();
  }
}