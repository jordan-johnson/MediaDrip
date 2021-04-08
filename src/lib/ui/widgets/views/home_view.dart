import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/database/feed/feed_lookup_dao.dart';
import 'package:mediadrip/models/database/feed/feed_lookup_dao_impl.dart';
import 'package:mediadrip/models/feed/feed_results.dart';
import 'package:mediadrip/services/feed_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/collections/feed.dart';
import 'package:mediadrip/ui/widgets/drip_dialog.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _HomeViewModel extends WidgetModel {
  final FeedService _feedService;
  final FeedLookupDao _feed;

  _HomeViewModel({@required BuildContext context}) :
    _feedService = locator<FeedService>(),
    _feed = FeedLookupDaoImpl(),
    super(context: context);

  Future<FeedResults> getFeed() async {
    await _feedService.load();

    return _feedService.results;
  }
}

class HomeView extends StatelessWidget {
  Widget feedErrorDialog(BuildContext context, String message) {
    print('test $message');
    return DripDialog(
      width: 400,
      height: 200,
      children: [
        Text('Hello!'),
        Text(message)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_HomeViewModel>(
      model: _HomeViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'MediaDrip',
          route: Routes.home,
          child: Feed(
            future: () => model.getFeed(),
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