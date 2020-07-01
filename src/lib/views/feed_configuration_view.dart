import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:mediadrip/views/models/feed_config_view_model.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';

class FeedConfigurationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FeedConfigViewModel>(
      model: FeedConfigViewModel(context:  context),
      builder: (model) {
        return DripWrapper(
          title: 'Configure Feed',
          route: Routes.feedConfiguration,
          child: Text('okay'),
        );
      }
    );
  }
}