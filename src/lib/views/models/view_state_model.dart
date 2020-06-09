import 'package:flutter/material.dart';

class ViewStateModel extends ChangeNotifier {
  String _currentView = 'MediaDrip';
  String get currentView => _currentView;

  String _currentRoute = '/';
  String get currentRoute => _currentRoute;
  
  void update(String view, String route) {
    _currentView = view;
    _currentRoute = route;
    
    notifyListeners();
  }
}