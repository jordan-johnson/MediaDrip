import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediadrip/domain/settings/settings.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/logging.dart';
import 'package:mediadrip/services/index.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/collections/index.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _SettingsViewModel extends WidgetModel {
  final Logger _log = getLogger('SettingsViewModel');
  final SettingsService _settingsService = locator<SettingsService>();

  Settings _settingsData = Settings();

  bool get darkMode => _settingsData.isDarkMode;
  bool get autoUpdate => _settingsData.updateYoutubeDLOnDownload;
  String get feedMaxEntries => _settingsData.feedMaxEntries.toString();
  String get applicationStorage => _settingsData.applicationStorage;

  TextEditingController applicationStorageTextController = TextEditingController();
  TextEditingController feedMaxEntriesTextController = TextEditingController();

  _SettingsViewModel({@required BuildContext context}) : super(context: context);

  @override
  Future<void> initialize() async {
    _settingsData = await _settingsService.getSettings();

    applicationStorageTextController.text = _settingsData.applicationStorage;
    feedMaxEntriesTextController.text = _settingsData.feedMaxEntries.toString();
  }

  Future<void> toggleAutomaticUpdates() async {
    _settingsData.setYoutubeDownloadAutomaticUpdate(
      !_settingsData.updateYoutubeDLOnDownload
    );

    await save();
  }

  Future<void> toggleDarkMode() async {
    _settingsData.setDarkMode(!_settingsData.isDarkMode);

    await save(notify: true);
  }

  /// Save settings
  /// 
  /// [notify], if true, will call the [Settings] model's notifyListeners 
  /// method to update the UI. This is useful for settings like dark mode.
  Future<void> save({bool notify}) async {
    _settingsData.setMaxEntries(feedMaxEntriesTextController.text);

    await _settingsService.saveSettings(_settingsData);

    if(notify) {
      _settingsData.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();

    applicationStorageTextController.dispose();
    feedMaxEntriesTextController.dispose();
  }
}

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_SettingsViewModel>(
      model: _SettingsViewModel(context: context),
      builder: (model) {
        return DripWrapper(
          title: 'Settings',
          route: Routes.settings,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => model.save(),
              child: Icon(Icons.save),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Container(
                child: ListView(
                  children: [
                    CardOfListTiles(
                      title: 'Storage Configuration',
                      icon: Icons.folder,
                      children: [
                        TextField(
                          controller: model.applicationStorageTextController,
                          decoration: InputDecoration(
                            labelText: 'Application Storage Directory',
                            prefixIcon: Icon(Icons.folder_open),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ],
                    ),
                    CardOfListTiles(
                      title: 'Youtube Downloader',
                      icon: Icons.cloud_download,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.update
                          ),
                          title: Text('Automatic updates'),
                          trailing: Switch(
                            value: model.autoUpdate,
                            onChanged: (_) => model.toggleAutomaticUpdates(),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          onTap: () => model.toggleAutomaticUpdates()
                        ),
                        ListTile(
                          title: Text('Manage configuration'),
                          leading: Icon(
                            Icons.settings_applications
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right
                          ),
                          onTap: () => Navigator.pushNamed(context, Routes.youtubeConfiguration)
                        ),
                      ],
                    ),
                    CardOfListTiles(
                      title: 'RSS Feed',
                      icon: Icons.rss_feed,
                      children: [
                        TextField(
                          controller: model.feedMaxEntriesTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'Max Entries',
                            prefixIcon: Icon(Icons.format_list_numbered),
                            alignLabelWithHint: true,
                          ),
                        ),
                        ListTile(
                          title: Text('Manage feeds'),
                          leading: Icon(
                            Icons.edit
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right
                          ),
                          onTap: () => Navigator.pushNamed(context, Routes.feedConfiguration)
                        )
                      ],
                    ),
                    CardOfListTiles(
                      title: 'Theme Customization',
                      icon: Icons.smartphone,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.settings_brightness
                          ),
                          title: Text('Dark Mode'),
                          trailing: Switch(
                            value: model.darkMode,
                            onChanged: (_) => model.toggleDarkMode(),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          onTap: () => model.toggleDarkMode(),
                        ),
                      ],
                    )
                  ],
                )
              )
            ),
          )
        );
      },
    );
  }
}