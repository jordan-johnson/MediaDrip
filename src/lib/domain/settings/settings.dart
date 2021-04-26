import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  static final String tableName = 'settings';

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

  /// Application settings.
  Settings();

  /// Application settings.
  /// 
  /// Parses and maps columns from database table to our object.
  Settings.fromTable(Map<String, dynamic> map) {
    bool parseDarkMode = map['dark_mode'] == 0 ? false : true;
    setDarkMode(parseDarkMode);

    bool parseToolingAutoUpdate = map['update_tooling'] == 0 ? false : true;
    setYoutubeDownloadAutomaticUpdate(parseToolingAutoUpdate);

    setMaxEntries(map['max_feed_entries']);
    setApplicationStoragePath(map['storage_path']);
    setYoutubeDownloadConfigurationPath(map['ytdl_config_path']);
  }

  void setYoutubeDownloadAutomaticUpdate(bool value) {
    _updateYoutubeDLOnDownload = value;
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
  }

  void setMaxEntries(dynamic value) {
    if(value is int) {
      _feedMaxEntries = value;
    } else if(value is String) {
      _feedMaxEntries = int.parse(value);
    } else {
      throw FormatException('Could not set max entries! Not an acceptable type', value);
    }
  }

  void setApplicationStoragePath(String value) {
    _applicationStorage = value;
  }

  void setYoutubeDownloadConfigurationPath(String value) {
    _youtubeConfiguration = value;
  }
}