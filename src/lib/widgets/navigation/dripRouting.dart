import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../page/dripPageManager.dart';

class DripRouting {
  DripPageManager _pageManager;

  DripRouting(this._pageManager);

  DripPage getRoot() {
    return _pageManager.getRootPage();
  }

  RouteFactory getRoutes() {
    return (settings) {
      final DripPage result = _pageManager.getPage(settings.name);

      if(result != null) {
        /// Cupertino creates an animation of right to left
        /// while MaterialPageRoute is bottom to top
        return CupertinoPageRoute(builder: (BuildContext context) => result);
      }
    };
  }
}