import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/feed/models/feed_entry.dart';
import 'package:mediadrip/services/view_manager_service.dart';
import 'package:mediadrip/utilities/image_helper.dart';

class FeedDateView extends StatelessWidget {
  final String label;
  final int gridCount = 3;
  final List<DripModel> entries;

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
        ListView.separated(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(),
          itemCount: entries.length,
          itemBuilder: (_, index) {
            return ListTile(
              leading: SizedBox(
                width: 100,
                height: 200,
                child: FutureBuilder<Image>(
                  future: NetworkImageHelper(url: entries[index].thumbnail).get(),
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
                      entries[index].title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      '${entries[index].dateTimeFormatted} by ${entries[index].author}',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ]
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.keyboard_arrow_right)]
              ),
              onTap: () => _viewManagerService.goTo('/browse', arguments: entries[index]),
            );
          },
        )
        // GridView.count(
        //   crossAxisCount: this.gridCount,
        //   physics: ScrollPhysics(),
        //   shrinkWrap: true,
        //   children: [
        //     for(var entry in entries)
        //       GestureDetector(
        //         onTap: () {
        //           _viewManagerService.goTo('/browse', arguments: entry);
        //         },
        //         child: SizedBox(
        //           width: 450,
        //           height: 300,
        //           child: FittedBox(fit: BoxFit.contain, child: entry.image)
        //         )
        //         // child: Container(
        //         //   width: 450,
        //         //   height: 300,
        //         //   child: FittedBox(
        //         //     fit: BoxFit.cover,
        //         //     child: entry.image
        //         //   ),
        //         // )
        //       )
        //   ],
        // )
      ],
    );
  }
}