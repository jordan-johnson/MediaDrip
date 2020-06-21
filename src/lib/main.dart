import 'package:flutter/material.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/settings_service.dart';
import 'package:mediadrip/services/view_manager_service.dart';
import 'package:mediadrip/sources.dart';
import 'package:provider/provider.dart';

class MediaDrip extends StatelessWidget {
  /// Application title (hopefully windows title will use this in a future Flutter version).
  final String title = 'MediaDrip';

  /// View service handles building and routing views.
  final ViewManagerService _viewManagerService = locator<ViewManagerService>();

  /// Settings service saves and retrieves data from storage.
  final SettingsService _settingsService = locator<SettingsService>();

  /// MediaDrip allows you to download, convert, merge, and trim videos and other media.
  /// 
  /// Visit the [github repository](https://github.com/jordan-johnson/MediaDrip) for more information.
  MediaDrip();

  @override
  Widget build(BuildContext context) {
    _settingsService.load();
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => _viewManagerService.state
        )
      ],
      child: MaterialApp(
        title: this.title,
        theme: AppTheme.getThemeData(),
        debugShowCheckedModeBanner: false,
        home: _viewManagerService.build(context),
        onGenerateRoute: _viewManagerService.getRoutes(),
        navigatorKey: _viewManagerService.navigationKey
      ) 
    );
  }
}

void main() {
  setupLocator();

  loadSources();

  runApp(MediaDrip());
}