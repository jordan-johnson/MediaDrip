import 'package:mediadrip/domain/settings/settings.dart';

class ISettingsRepository {
  Future<Settings> getSettings() => throw Exception('Not implemented.');
  Future<void> saveSettings(Settings settings) => throw Exception('Not implemented.');
}