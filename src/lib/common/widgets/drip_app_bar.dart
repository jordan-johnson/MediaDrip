import 'package:flutter/material.dart';
import 'package:mediadrip/services/navigation_service.dart';
import 'package:mediadrip/views/models/view_state_model.dart';
import 'package:provider/provider.dart';

class DripAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  DripAppBar({Key key})
    : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Provider.of<NavigationService>(context, listen: false);
    return Consumer<ViewStateModel>(
      builder: (_, viewStateModel, __) {
        bool isRootRoute = viewStateModel.currentView == 'MediaDrip';

        return AppBar(
          title: Text(viewStateModel.currentView),
          automaticallyImplyLeading: isRootRoute,
          leading: !isRootRoute ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => navigator.back()
          ) : null,
          // automaticallyImplyLeading: model.isRoot,
          // leading: model.leading(context)
        );
      },
    );
  }
}