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

      return Settings.fromMap(results.first);
    });

    return _settings;
  }

  Future<void> saveSettings(Settings settings) {
    return null;
  }
}