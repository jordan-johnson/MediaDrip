import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/index.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/collections/index.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class _SettingsViewModel extends WidgetModel {
  final SettingsService _settingsService = locator<SettingsService>();

  bool get darkMode => _settingsService.data.isDarkMode;
  String get feedMaxEntries => _settingsService.data.feedMaxEntries.toString();
  String get applicationStorage => _settingsService.data.applicationStorage;

  TextEditingController applicationStorageTextController = TextEditingController();
  TextEditingController feedMaxEntriesTextController = TextEditingController();

  _SettingsViewModel({@required BuildContext context}) : super(context: context);

  void toggleDarkMode() {
    _settingsService.data.isDarkMode = !_settingsService.data.isDarkMode;

    save();
  }

  Future<void> save() async {
    // parse max feed entries
    _settingsService.data.feedMaxEntries = int.parse(feedMaxEntriesTextController.text);

    notifyListeners();

    await _settingsService.save();
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
                          controller: model.applicationStorageTextController..text = model.applicationStorage,
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
                            value: true,
                            onChanged: (_) => print(''),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          onTap: () => model.toggleDarkMode(),
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
                          controller: model.feedMaxEntriesTextController..text = model.feedMaxEntries,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
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