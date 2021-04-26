import 'package:mediadrip/domain/settings/isettings_repository.dart';
import 'package:mediadrip/domain/settings/settings.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';

class SettingsRepository implements ISettingsRepository {
  final SqliteDatabase _dataSource = locator<SqliteDatabase>();

  Settings _settings;

  Future<Settings> getSettings() async {
    if(_settings != null)
      return _settings;
    
    await _dataSource.init();

    _settings = await _dataSource.retrieve<Settings>((source) {
      final results = source.select('SELECT * FROM ${Settings.tableName} LIMIT 1');

      return Settings.fromTable(results.first);
    });

    return _settings;
  }
  
  Future<void> saveSettings(Settings settings) async {
    _settings = settings;
    
    _dataSource.execute((source) {
      final statement = source.prepare('''UPDATE ${Settings.tableName} SET 
        dark_mode = ?, 
        update_tooling = ?, 
        max_feed_entries = ?, 
        storage_path = ?, 
        ytdl_config_path = ?''');
      
      statement.execute([
        settings.isDarkMode ? 1 : 0,
        settings.updateYoutubeDLOnDownload ? 1 : 0,
        settings.feedMaxEntries,
        settings.applicationStorage,
        settings.youtubeConfiguration
      ]);
      statement.dispose();
    });
  }
}