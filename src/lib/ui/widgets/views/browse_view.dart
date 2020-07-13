import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/file/drip.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/image_helper.dart';
import 'package:mediadrip/utilities/index.dart';

class _BrowseViewModel extends WidgetModel {
  final Drip drip;

  final DownloadService _downloadService = locator<DownloadService>();

  bool get isViewingDrip => drip != null;

  _BrowseViewModel({
    @required BuildContext context,
    this.drip
  }) : super(context: context);

  @override
  Future<void> initialize() async {
    if(drip != null) {
      notifyListeners();
    }
  }

  Future<Image> getFullSizeImage() async {
    return await NetworkImageHelper(url: drip.image).get();
  }

  Future<void> downloadMedia() async {
    await _downloadService.dripToDisk(drip);
  }
}

class BrowseView extends StatelessWidget {
  final Drip drip;

  BrowseView({this.drip});

  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_BrowseViewModel>(
      model: _BrowseViewModel(context: context, drip: this.drip),
      builder: (model) {
        return DripWrapper(
          title: 'Browse',
          route: Routes.browse,
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: (model.isViewingDrip) ? ListView(
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