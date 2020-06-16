import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;

    notifyListeners();
  }

  String _applicationStorage = '';
  String get applicationStorage => _applicationStorage;

  set applicationStorage(String value) {
    _applicationStorage = value;

    notifyListeners();
  }

  String _youtubeConfiguration = '';
  String get youtubeConfiguration => _youtubeConfiguration;

  SettingsModel();

  SettingsModel.fromJson(Map<String, dynamic> json) {
    _isDarkMode = json['dark_mode'];
    _applicationStorage = json['application_storage'];
    _youtubeConfiguration = json['youtube_conf'];

    notifyListeners();
  }

  Map<String, dynamic> toJson() =>
  {
    'dark_mode': _isDarkMode,
    'application_storage': _applicationStorage,
    'youtube_conf': _youtubeConfiguration
  };
}