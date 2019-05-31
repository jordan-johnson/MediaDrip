import 'package:flutter/material.dart';
import '../page/dripPageManager.dart';

class DripRouting {
  DripPageManager _pageManager;

  DripRouting(this._pageManager);

  RouteFactory getRoutes() {
    return (settings) {
      DripPage result = _pageManager.getPage(settings.name);

      if(result != null) {
        return MaterialPageRoute(builder: (BuildContext context) => result);
      }
    };
  }
}