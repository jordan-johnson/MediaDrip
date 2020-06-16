import 'package:flutter/material.dart';
import 'package:mediadrip/views/models/view_model.dart';

class SettingsViewModel extends ViewModel {
  bool get darkMode => settings.data.isDarkMode;
  String get applicationStorage => settings.data.applicationStorage;

  TextEditingController applicationStorageTextController = TextEditingController();

  SettingsViewModel({@required BuildContext context}) : super(context: context);

  void toggleDarkMode() {
    settings.data.isDarkMode = !settings.data.isDarkMode;

    notifyListeners();

    settings.save();
  }

  @override
  void dispose() {
    super.dispose();

    applicationStorageTextController.dispose();
  }
}