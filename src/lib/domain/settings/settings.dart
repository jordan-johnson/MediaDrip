import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  bool _updateYoutubeDLOnDownload = true;
  bool get updateYoutubeDLOnDownload => _updateYoutubeDLOnDownload;

  int _feedMaxEntries = 30;
  int get feedMaxEntries => _feedMaxEntries;

  String _applicationStorage = '';
  String get applicationStorage => _applicationStorage;

  String _youtubeConfiguration = '';
  String get youtubeConfiguration => _youtubeConfiguration;

  set updateYoutubeDLOnDownload(bool value) {
    _updateYoutubeDLOnDownload = value;

    notifyListeners();
  }

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

  Settings();

  Settings.fromMap(Map<String, dynamic> map) {
    isDarkMode = map['dark_mode'] == 0 ? false : true;
    updateYoutubeDLOnDownload = map['update_tooling'] == 0 ? false : true;
    feedMaxEntries = map['max_feed_entries'];
    applicationStorage = map['storage_path'];
    youtubeConfiguration = map['ytdl_config_path'];
  }
}