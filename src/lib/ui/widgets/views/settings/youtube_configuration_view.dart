import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/download_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _YoutubeConfigurationViewModel extends WidgetModel {
  final DownloadService _downloadService = locator<DownloadService>();

  final TextEditingController configurationTextController = TextEditingController();

  _YoutubeConfigurationViewModel({@required BuildContext context}) : super(context: context);

  @override
  Future<void> initialize() async {
    var contents = await _downloadService.readContentsOfConfiguration();

    configurationTextController.text = contents;
  }

  @override
  void dispose() {
    super.dispose();

    configurationTextController.dispose();
  }
}

class YoutubeConfigurationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_YoutubeConfigurationViewModel>(
      model: _YoutubeConfigurationViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'Configure Youtube Downloader',
          route: Routes.youtubeConfiguration,
          child: TextFormField(
            controller: model.configurationTextController,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor
                )
              )
            ),
          )
        );
      },
    );
  }
}