import 'package:flutter/material.dart';
import 'package:mediadrip/views/models/view_state_model.dart';

class NavigationService {
  ViewStateModel viewStateModel;

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
    
  Future<dynamic> goTo(String label, String route) {
    _updateViewState(label, route);

    return navigatorKey.currentState.pushNamed(route);
  }

  bool back() {
    if(navigatorKey.currentState.canPop())
    {
      _updateViewState('MediaDrip', '/');
      
      navigatorKey.currentState.pop();

      return true;
    }

    return false;
  }

  void _updateViewState(String label, String route) => viewStateModel.update(label, route);
}