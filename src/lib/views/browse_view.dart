import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/common/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:mediadrip/views/models/browse_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';

class BrowseView extends StatelessWidget{
  final DripModel item;

  BrowseView({this.item});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BrowseViewModel>(
      model: BrowseViewModel(context: context, drip: this.item),
      builder: (model) {
        return DripWrapper(
          title: 'Browse',
          route: Routes.browse,
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: (model.isViewingMedia) ? ListView(
              children: [
                Container(
                  height: 300,
                  child: FutureBuilder<Image>(
                    future: model.getFullSizeImage(),
                    builder: (_, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasData) {
                          return Image(image: snapshot.data.image);
                        } else {
                          return Image.asset('lib/assets/images/image_unavailable.png');
                        }
                      } else {
                        return Container(height: 200, child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  )
                ),
                Text(
                  model.drip.title,
                  style: Theme.of(context).textTheme.headline5
                ),
                Text('${model.drip.author} \u22C5 ${model.drip.dateTimeFormatted()}'),
                Divider(),
                Text(
                  model.drip.description ?? 'No description.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ) : Text('File picker not yet available.'),
            floatingActionButton: (model.drip != null && model.drip.isDownloadableLink) ? 
              FloatingActionButton(
                onPressed: () async => model.downloadMedia(),
                child: Icon(Icons.save),
              ) : null
          )
        );
      },
    );
  }
}