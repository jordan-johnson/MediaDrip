import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/common/widgets/feed/feed_date_view.dart';
import 'package:mediadrip/views/models/home_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';
import 'package:mediadrip/views/view.dart';

class HomeView extends View {
  @override
  String get label => 'MediaDrip';
  
  @override
  String get routeAddress => '/';

  @override
  IconData get icon => Icons.home;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>(
      model: HomeViewModel(context: context),
      builder: (model) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: (model.loading) ? 
            Center(
              child: CircularProgressIndicator(),
            ) : ListView(
            children: [
              FeedDateView(
                label: 'Today',
                entries: model.today,
              ),
              FeedDateView(
                label: 'Yesterday',
                entries: model.yesterday
              ),
              FeedDateView(
                label: 'This week',
                entries: model.thisWeek,
              ),
              FeedDateView(
                label: 'This month',
                entries: model.thisMonth,
              ),
              FeedDateView(
                label: 'Older',
                entries: model.older,
              )
              // DripHeader(
              //   header: 'Today',
              //   icon: Icons.calendar_today,
              // ),
              // GridView.count(
              //   crossAxisCount: model.gridCount,
              //   // childAspectRatio: 3 / 2,
              //   physics: ScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     for(var entry in model.today)
              //       Column(
              //         children: [
              //           Image.network(entry.media.thumbnail.url),
              //           Text('hello')
              //         ],
              //       )
              //   ],
              // ),
              // DripHeader(
              //   header: 'Yesterday',
              //   icon: Icons.calendar_today,
              // ),
              // GridView.count(
              //   crossAxisCount: model.gridCount,
              //   // childAspectRatio: 3 / 2,
              //   physics: ScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     for(var entry in model.yesterday)
              //       Column(
              //         children: [
              //           Image.network(entry.media.thumbnail.url),
              //           Text('hello')
              //         ],
              //       )
              //   ],
              // ),
              // DripHeader(
              //   header: 'This Week',
              //   icon: Icons.calendar_today,
              // ),
              // GridView.count(
              //   crossAxisCount: model.gridCount,
              //   // childAspectRatio: 3 / 2,
              //   physics: ScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     for(var entry in model.thisWeek)
              //       Column(
              //         children: [
              //           Image.network(entry.media.thumbnail.url),
              //           Text('hello')
              //         ],
              //       )
              //   ],
              // ),
              // DripHeader(
              //   header: 'This Month',
              //   icon: Icons.calendar_today,
              // ),
              // GridView.count(
              //   crossAxisCount: model.gridCount,
              //   // childAspectRatio: 3 / 2,
              //   physics: ScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     for(var entry in model.thisMonth)
              //       Column(
              //         children: [
              //           Image.network(entry.media.thumbnail.url),
              //           Text('hello')
              //         ],
              //       )
              //   ],
              // ),
              // DripHeader(
              //   header: 'Older',
              //   icon: Icons.calendar_today,
              // ),
              // GridView.count(
              //   crossAxisCount: model.gridCount,
              //   // childAspectRatio: 3 / 2,
              //   physics: ScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     for(var entry in model.older)
              //       Column(
              //         children: [
              //           Image.network(entry.media.thumbnail.url),
              //           Text('hello')
              //         ],
              //       )
              //   ],
              // ),
            ]
          ),
        );
      }
    );
  }
}