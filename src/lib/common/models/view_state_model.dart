import 'package:flutter/material.dart';
import 'package:mediadrip/views/view.dart';

class ViewStateModel extends ChangeNotifier {
  View _view;
  View get view => _view;

  set view(View view) {
    _view = view;

    notifyListeners();
  }
}