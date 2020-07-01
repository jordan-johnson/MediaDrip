import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:mediadrip/views/models/youtube_config_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';

class YoutubeConfigurationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<YoutubeConfigViewModel>(
      model: YoutubeConfigViewModel(context:  context),
      builder: (model) {
        return DripWrapper(
          title: 'Configure Youtube Downloader',
          route: Routes.youtubeConfiguration,
          child: TextFormField(
            controller: model.configurationText,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,

                )
              )
            ),
          )
        );
      }
    );
  }
}