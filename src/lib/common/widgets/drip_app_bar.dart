import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/view_state_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/view_manager_service.dart';
import 'package:provider/provider.dart';

class DripAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ViewManagerService _viewService = locator<ViewManagerService>();

  @override
  final Size preferredSize;

  DripAppBar({Key key})
    : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewStateModel>(
      builder: (_, viewStateModel, __) {
        var isRoot = viewStateModel.view.routeAddress == '/';
        return AppBar(
          title: Text(viewStateModel.view.label),
          automaticallyImplyLeading: isRoot,
          leading: !isRoot ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _viewService.goBack()
          ) : null,
          // automaticallyImplyLeading: model.isRoot,
          // leading: model.leading(context)
        );
      },
    );
  }
}