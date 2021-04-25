import 'package:mediadrip/domain/settings/isettings_repository.dart';
import 'package:mediadrip/domain/settings/settings.dart';
import 'package:mediadrip/domain/settings/settings_repository.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/database/data_source.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';
import 'package:sqlite3/sqlite3.dart';

class SettingsService {
  final ISettingsRepository _settingsRepository = SettingsRepository();

  Future<Settings> getSettings() async {
    return await _settingsRepository.getSettings();
  }

  void update() {
    // _dataSource.execute((source) {
    //   final statement = source.prepare('''UPDATE $_tableName SET 
    //     dark_mode = ?, 
    //     update_tooling = ?, 
    //     max_feed_entries = ?, 
    //     storage_path = ?, 
    //     ytdl_config_path = ?''');
      
    //   statement.execute([
    //     data.isDarkMode,
    //     data.updateYoutubeDLOnDownload,
    //     data.feedMaxEntries,
    //     data.applicationStorage,
    //     data.youtubeConfiguration
    //   ]);
    //   statement.dispose();
    // });
  }
}