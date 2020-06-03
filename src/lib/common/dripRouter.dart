import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/views/view.dart';

class DripRouter {
  List<View> _routes = List();

  void registerRoutes(List<View> routes) {
    _routes.addAll(routes);
  }

  RouteFactory getRoutes() {
    return (settings) {
      for(final route in _routes) {
        if(settings.name == route.routeAddress()) {
          return CupertinoPageRoute(builder: (_) => route);
        }
      }

      return null;
    };
  }
}