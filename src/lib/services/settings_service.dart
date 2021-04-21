import 'package:mediadrip/domain/settings/settings.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/database/data_source.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';
import 'package:sqlite3/sqlite3.dart';

class SettingsService {
  final DataSource<Database> _dataSource = locator<SqliteDatabase>();

  final String _tableName = 'settings';

  /// The data model for our application.
  /// 
  /// The model extends `ChangeNotifier`, notifying `Consumer`s of changes.
  Settings data;

  /// `SettingsService` acts as a middle-man between the database and settings model.
  /// 
  /// Essentially a Dao implementation but it needs to be accessible everywhere.
  SettingsService();

  Future<Settings> load() async {
    await _dataSource.init();

    return await _dataSource.retrieve<Settings>((source) {
      final results = source.select('SELECT * FROM $_tableName LIMIT 1');

      return Settings.fromMap(results.first);
    });
  }

  void update() {
    _dataSource.execute((source) {
      final statement = source.prepare('''UPDATE $_tableName SET 
        dark_mode = ?, 
        update_tooling = ?, 
        max_feed_entries = ?, 
        storage_path = ?, 
        ytdl_config_path = ?''');
      
      statement.execute([
        data.isDarkMode,
        data.updateYoutubeDLOnDownload,
        data.feedMaxEntries,
        data.applicationStorage,
        data.youtubeConfiguration
      ]);
      statement.dispose();
    });
  }
}