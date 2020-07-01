import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';

class ViewModel extends ChangeNotifier {
  final BuildContext context;
  final SettingsService settings;

  ViewModel({@required this.context}) : settings = locator<SettingsService>() {
    initialize();
  }

  Future<void> initialize() async {}
}