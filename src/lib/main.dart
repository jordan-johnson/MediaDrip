import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/file/settings.dart';
import 'package:mediadrip/services/database/data_source.dart';
import 'package:mediadrip/services/database/sqlite_database.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/sources.dart';
import 'package:mediadrip/ui/theme/theme.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:provider/provider.dart';

class MediaDrip extends StatelessWidget {
  /// Application title
  final String title = 'MediaDrip';

  /// Settings service saves and retrieves data from storage.
  final SettingsService _settingsService = locator<SettingsService>();

  final DataSource _databaseContext = SqliteDatabase();

  /// MediaDrip allows you to download, convert, merge, and trim videos and other media.
  /// 
  /// Visit the [github repository](https://github.com/jordan-johnson/MediaDrip) for more information.
  MediaDrip();

  Future<Settings> loadApplicationSettings() async {
    await _databaseContext.init();
    await _databaseContext.openConnection();

    // get settings from database

    await _databaseContext.closeConnection();
  }

  /// Builds the app.
  /// 
  /// Returns a FutureBuilder that waits until our settings are loaded. This is essential for loading 
  /// settings we need to display our app properly (i.e. dark theme)
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _settingsService.load(),
      builder: (BuildContext context, AsyncSnapshot<Settings> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: snapshot.data)
              ],
              child: Consumer<Settings>(
                builder: (_, model, __) {
                  return MaterialApp(
                    title: this.title,
                    theme: AppTheme.getThemeDynamic(model.isDarkMode),
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: Routes.routeGenerator,
                    onUnknownRoute: Routes.errorRoute
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        }
        return Container();
      },
    );
  }
}

void main() {
  setupLocator();
  loadSources();

  runApp(MediaDrip());
}