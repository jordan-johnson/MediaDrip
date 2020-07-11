import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/feed/index.dart';
import 'package:mediadrip/common/providers/widget_provider.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';

class Feed<T extends IFeedItem> extends StatelessWidget {
  final Future<FeedResultsModel> future;
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
    return WidgetProvider<FeedModel>(
      model: FeedModel(context: context, future: this.future, itemBuilder: this.itemBuilder),
      builder: (model) {
        return (model.isLoading) ? 
          Center(child: CircularProgressIndicator()) :
          RefreshIndicator(
            onRefresh: () => model.refresh(),
            child: ListView(
              children: _propagateFeed(context, model.results),
            )
          );
      }
    );
  }

  List<Widget> _propagateFeed(BuildContext context, FeedResultsModel results) {
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