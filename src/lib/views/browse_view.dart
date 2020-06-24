import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/views/models/browse_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';
import 'package:mediadrip/views/view.dart';

class BrowseView extends View {
  @override
  String get label => 'Browse';
  
  @override
  String get routeAddress => '/browse';

  @override
  IconData get icon => Icons.folder;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BrowseViewModel>(
      model: BrowseViewModel(context: context, arguments: routeArguments),
      builder: (model) {
        return Scaffold(
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
                model.currentDrip.title,
                style: Theme.of(context).textTheme.headline5
              ),
              Text('${model.currentDrip.author} \u22C5 ${model.currentDrip.dateTimeFormatted}'),
              Divider(),
              Text(
                model.currentDrip.description ?? 'No description.',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ) : Text('File picker not yet available.'),
          floatingActionButton: (model.currentDrip.isDownloadableLink) ? FloatingActionButton(
            onPressed: () async => model.downloadMedia(),
            child: Icon(Icons.save),
          ) : null
        );
      },
    );
  }
}