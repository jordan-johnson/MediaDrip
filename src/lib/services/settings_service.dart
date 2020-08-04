import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/file/settings.dart';
import 'package:mediadrip/services/path_service.dart';

class SettingsService {
  /// The directory where the settings file will be stored.
  /// 
  /// NOTE: The configuration directory also stores the youtube-dl configuration file. 
  /// Any other config files will be placed there as well.
  /// 
  /// Refer to [AvailableDirectories] for more information.
  final AvailableDirectories _settingsDirectoryEnum = AvailableDirectories.configuration;

  /// The json file that will store all key-value pairs for our application.
  final String _settingsFileName = 'settings.json';

  /// The path service is needed for parsing our requests; retrieving and saving our model 
  /// to storage.
  /// 
  /// Refer to [PathService] for more information.
  final PathService _path = locator<PathService>();

  /// The model for our application. Values are encoded and decoded here.
  /// 
  /// The [Settings] extends `ChangeNotifier`, notifying `Consumer`s of changes to 
  /// the model.
  Settings data;

  /// [SettingsService] provides functionality for storing application settings for later use.
  SettingsService();

  /// Asynchronously loads the settings json file.
  /// 
  /// If the settings file does not exist, one will be created based on the template found in 
  /// the assets folder.
  Future<Settings> load() async {
    String contents;

    var fileExists = await _path.fileExistsInDirectory(_settingsFileName, _settingsDirectoryEnum);

    if(fileExists) {
      var file = await _path.getFileFromFileName(_settingsFileName, _settingsDirectoryEnum);

      contents = await file.readAsString();
    } else {
      // load template file from assets
      contents = await rootBundle.loadString('lib/assets/$_settingsFileName');
    }

    _decodeContents(contents);

    if(!fileExists)
      await _writeInitialPaths();

    return data;
  }

  /// Encodes the current [SettingsModel] and saves the file.
  Future<void> save() async {
    var encoded = jsonEncode(data);

    await _path.createFileInDirectory(_settingsFileName, encoded, _settingsDirectoryEnum);
  }

  /// Decodes the provided [contents] and saves the [Settings] in our [data] property.
  void _decodeContents(String contents) {
    Map<String, dynamic> decoded = jsonDecode(contents);

    data = Settings.fromJson(decoded);
  }

  /// This method is used on creation of our settings file to write the initial paths for 
  /// our [Settings], such as [SettingsModel.applicationStorage].
  /// 
  /// Simply put, the settings file template needs information about the paths for our 
  /// current device.
  /// 
  /// Refer to the [load] method for more information.
  Future<void> _writeInitialPaths() async {
    data.applicationStorage = await _path.mediaDripDirectory;

    await save();
  }
}