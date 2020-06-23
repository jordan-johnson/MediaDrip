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
                  child: model.currentDrip.image,
                ),
                Text(
                  model.currentDrip.title,
                  style: Theme.of(context).textTheme.headline5
                ),
                Text('${model.currentDrip.author} \u22C5 ${model.currentDrip.dateTimeFormatted}'),
                Divider(),
                Text(
                  model.currentDrip.description,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ) : Text('File picker not yet available.'),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.downloadMedia(),
            child: Icon(Icons.save),
          )
        );
      },
    );
  }
}