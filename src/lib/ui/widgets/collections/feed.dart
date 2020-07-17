import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mediadrip/models/feed/feed_results.dart';
import 'package:mediadrip/models/feed/ifeed_item.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/drip_header.dart';

class _FeedModel extends WidgetModel {
  final Future<FeedResults> Function() future;
  final Widget Function(BuildContext context, IFeedItem entry) itemBuilder;

  Future<FeedResults> Function() test;

  FeedResults results = FeedResults();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  _FeedModel({
    @required BuildContext context,
    @required this.future,
    @required this.itemBuilder
  });

  @override
  Future<void> initialize() async {
    isLoading = true;

    results.clearAll();
    results = await this.future();

    isLoading = false;
  }

  set isLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }
}

class Feed<T extends IFeedItem> extends StatelessWidget {
  final Future<FeedResults> Function() future;
  final Widget Function(BuildContext context, IFeedItem item) itemBuilder;

  /// Creates a date-based feed.
  /// 
  /// Dates are organized according to [FeedResultsModel].
  Feed({
    @required this.future,
    @required this.itemBuilder
  });

  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_FeedModel>(
      model: _FeedModel(context: context, future: this.future, itemBuilder: this.itemBuilder),
      builder: (model) {
        return (model.isLoading) ? 
          Center(child: CircularProgressIndicator()) :
          RefreshIndicator(
            onRefresh: () => model.initialize(),
            child: ListView(
              children: _propagateFeed(context, model.results),
            )
          );
      }
    );
  }

  List<Widget> _propagateFeed(BuildContext context, FeedResults results) {
    return [
      if(results.today.length > 0)
        _groupedResultsByCategory(context, 'Today', results.today),
      if(results.yesterday.length > 0)
        _groupedResultsByCategory(context, 'Yesterday', results.yesterday),
      if(results.thisWeek.length > 0)
        _groupedResultsByCategory(context, 'This week', results.thisWeek),
      if(results.thisMonth.length > 0)
        _groupedResultsByCategory(context, 'This month', results.thisMonth),
      if(results.older.length > 0)
        _groupedResultsByCategory(context, 'Older', results.older)
    ];
  }

  Widget _groupedResultsByCategory(BuildContext context, String title, List<IFeedItem> items) {
    return Column(
      children: [
        DripHeader(
          header: title,
          icon: Icons.calendar_today,
        ),
        ListView.separated(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(),
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            var item = items.elementAt(index);

            return this.itemBuilder(ctx, item);
          },
        )
      ],
    );
  }
}