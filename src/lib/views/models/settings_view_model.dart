import 'package:flutter/material.dart';
import 'package:mediadrip/views/models/view_model.dart';

class SettingsViewModel extends ViewModel {
  bool get darkMode => settings.data.isDarkMode;
  String get feedMaxEntries => settings.data.feedMaxEntries.toString();
  String get applicationStorage => settings.data.applicationStorage;

  TextEditingController applicationStorageTextController = TextEditingController();
  TextEditingController rssFeedMaxEntriesTextController = TextEditingController();

  SettingsViewModel({@required BuildContext context}) : super(context: context);

  void toggleDarkMode() {
    settings.data.isDarkMode = !settings.data.isDarkMode;

    save();
  }

  Future<void> save() async {
    settings.data.feedMaxEntries = int.parse(rssFeedMaxEntriesTextController.text);

    notifyListeners();

    await settings.save();
  }

  @override
  void dispose() {
    super.dispose();

    applicationStorageTextController.dispose();
    rssFeedMaxEntriesTextController.dispose();
  }
}