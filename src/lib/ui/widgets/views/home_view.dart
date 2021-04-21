import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mediadrip/domain/feed/feed_lookup_repository.dart';
import 'package:mediadrip/domain/feed/feed_results.dart';
import 'package:mediadrip/domain/settings/settings_repository.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/collections/feed.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _HomeViewModel extends WidgetModel {
  final SettingsRepository _settingsRepository;
  final FeedLookupRepository _feedLookupRepository;

  _HomeViewModel({@required BuildContext context}) :
    _settingsRepository = locator<SettingsRepository>(),
    _feedLookupRepository = FeedLookupRepository(),
    super(context: context);

  Future<FeedResults> getFeedResults() async {
    final lookups = await _feedLookupRepository.getAllFeeds();
    final maxEntries = await _settingsRepository.getSettings().then((x) => x.feedMaxEntries);

    if(lookups == null || lookups.isEmpty)
      return FeedResults();

    // download feeds
    // order entries by date
    // remove excess
    // fill feedresults
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_HomeViewModel>(
      model: _HomeViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'MediaDrip',
          route: Routes.home,
          child: Feed(
            future: () => model.getFeedResults(),
            itemBuilder: (ctx, item) {
              return ListTile(
                leading: SizedBox(
                  width: 100,
                  height: 200,
                  child: FutureBuilder<Image>(
                    future: NetworkImageHelper(url: item.thumbnail).get(),
                    builder: (_, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasData) {
                          return Image(image: snapshot.data.image, fit: BoxFit.cover);
                        } else {
                          return Image.asset('lib/assets/images/image_unavailable.png', fit: BoxFit.cover);
                        }
                      } else {
                        return Container(height: 60, child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  )
                ),
                title: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: Theme.of(ctx).textTheme.headline5,
                      ),
                      Text(
                        '${item.dateTimeFormatted()} by ${item.author}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: Theme.of(ctx).textTheme.headline6,
                      ),
                    ]
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.keyboard_arrow_right)]
                ),
                onTap: () => Navigator.pushNamed(ctx, '/browse', arguments: {'view': item})
              );
            },
          )
        );
      },
    );
  }
}