import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  int _feedMaxEntries = 30;
  int get feedMaxEntries => _feedMaxEntries;

  String _applicationStorage = '';
  String get applicationStorage => _applicationStorage;

  String _youtubeConfiguration = '';
  String get youtubeConfiguration => _youtubeConfiguration;

  Settings();

  set isDarkMode(bool value) {
    _isDarkMode = value;
    
    notifyListeners();
  }

  set feedMaxEntries(int value) {
    _feedMaxEntries = value;

    notifyListeners();
  }

  set applicationStorage(String value) {
    _applicationStorage = value;

    notifyListeners();
  }

  set youtubeConfiguration(String value) {
    _youtubeConfiguration = value;

    notifyListeners();
  }

  Settings.fromJson(Map<String, dynamic> json) {
    isDarkMode = json['dark_mode'];
    feedMaxEntries = json['feed_max_entries'];
    applicationStorage = json['application_storage'];
    youtubeConfiguration = json['youtube_conf'];
  }

  Map<String, dynamic> toJson() => {
    'dark_mode': _isDarkMode,
    'feed_max_entries': _feedMaxEntries,
    'application_storage': _applicationStorage,
    'youtube_conf': _youtubeConfiguration
  };
}