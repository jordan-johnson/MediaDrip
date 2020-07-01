import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_wrapper.dart';
import 'package:mediadrip/common/widgets/feed/feed_date_view.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:mediadrip/views/models/home_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>(
      model: HomeViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'MediaDrip',
          route: Routes.home,
          child: (model.loading) ? 
            Center(child: CircularProgressIndicator()) : 
            RefreshIndicator(
              onRefresh: () => model.initialize(),
              child: ListView(
                children: [
                  if(model.today.length > 0)
                    FeedDateView(
                      label: 'Today',
                      entries: model.today,
                    ),
                  if(model.yesterday.length > 0)
                    FeedDateView(
                      label: 'Yesterday',
                      entries: model.yesterday
                    ),
                  if(model.thisWeek.length > 0)
                    FeedDateView(
                      label: 'This week',
                      entries: model.thisWeek,
                    ),
                  if(model.thisMonth.length > 0)
                    FeedDateView(
                      label: 'This month',
                      entries: model.thisMonth,
                    ),
                  if(model.older.length > 0)
                    FeedDateView(
                      label: 'Older',
                      entries: model.older,
                    )
                ]
              ),
            )
        );
      }
    );
  }
}