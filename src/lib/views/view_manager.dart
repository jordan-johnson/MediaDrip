import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/drawer/drip_drawer.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/common/widgets/drip_app_bar.dart';
import 'package:mediadrip/views/browse_view.dart';
import 'package:mediadrip/views/download_view.dart';
import 'package:mediadrip/views/home_view.dart';
import 'package:mediadrip/views/settings_view.dart';
import 'package:mediadrip/views/tools_view.dart';
import 'package:mediadrip/views/view.dart';

class ViewManager {
  List<View> _views = List();

  ViewManager() {
    _addAllViews([
      HomeView(),
      BrowseView(),
      DownloadView(),
      ToolsView(),
      SettingsView(),
    ]);
  }

  RouteFactory getRoutes() {
    return (settings) {
      for(final view in _views) {
        if(settings.name == view.routeAddress) {
          return CupertinoPageRoute(builder: (context) => getView(context, view.label));
        }
      }

      return null;
    };
  }

  Widget getView(BuildContext context, String title) {
    View view = _views.firstWhere((view) => view.label == title);

    if(view != null) {
      // wraps our view for a consistent theme
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: DripAppBar(),
        body: view.build(context),
        drawer: DripDrawer(items: _views),
      );
    }

    return null;
  }

  List<View> getAllViews() => _views;
  void _addAllViews(List<View> views) => _views.addAll(views);
}