import 'package:mediadrip/domain/settings/isettings_repository.dart';
import 'package:mediadrip/domain/settings/settings.dart';
import 'package:mediadrip/domain/settings/settings_repository.dart';
import 'package:mediadrip/logging.dart';

export 'package:mediadrip/domain/settings/settings.dart';

class SettingsService {
  final Logger _log = getLogger('SettingsService');
  final ISettingsRepository _settingsRepository = SettingsRepository();

  Future<Settings> getSettings() async {
    try {
      return await _settingsRepository.getSettings();
    } catch(e, s) {
      _log.e(e.toString(), 'Settings Retrieval Failure', s);
    }

    return Settings();
  }

  Future<void> saveSettings(Settings settings) async {
    try {
      await _settingsRepository.saveSettings(settings);
    } catch(e, s) {
      _log.e(e.toString(), 'Settings Save Failure', s);
    }
  }
}