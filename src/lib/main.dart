import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/sources.dart';
import 'package:mediadrip/ui/theme/theme.dart';
import 'package:mediadrip/utilities/routes.dart';
import 'package:mediadrip/domain/settings/settings.dart';
import 'package:provider/provider.dart';

class MediaDrip extends StatelessWidget {
  /// Application title
  final String title = 'MediaDrip';

  /// Settings service saves and retrieves data from storage.
  final SettingsService _settingsService = locator<SettingsService>();

  /// MediaDrip allows you to download, convert, merge, and trim videos and other media.
  /// 
  /// Visit the [github repository](https://github.com/jordan-johnson/MediaDrip) for more information.
  MediaDrip();

  /// Builds the app.
  /// 
  /// Returns a FutureBuilder that waits until our settings are loaded. This is essential for loading 
  /// settings we need to display our app properly (i.e. dark theme)
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _settingsService.getSettings(),
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