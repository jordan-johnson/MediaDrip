import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed/feed_entry.dart';
import 'package:mediadrip/services/view_manager_service.dart';

class FeedDateView extends StatelessWidget {
  final String label;
  final int gridCount = 3;
  final List<FeedEntry> entries;

  final ViewManagerService _viewManagerService = locator<ViewManagerService>();

  FeedDateView({
    @required this.label,
    @required this.entries
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DripHeader(
          header: this.label,
          icon: Icons.calendar_today,
        ),
        Divider(),
        GridView.count(
          crossAxisCount: this.gridCount,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            for(var entry in entries)
              GestureDetector(
                onTap: () {
                  _viewManagerService.goTo('/browse', arguments: entry.modelToCollection());
                },
                child: Column(
                  children: [
                    Image.network(entry.media.thumbnail.url),
                    Text(entry.media.title)
                  ],
                )
              )
          ],
        )
      ],
    );
  }
}