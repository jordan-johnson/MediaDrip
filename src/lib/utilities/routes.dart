import 'package:flutter/cupertino.dart';
import 'package:mediadrip/ui/widgets/views/index.dart';

class Routes {
  static const home = '/';
  static const browse = '/browse';
  static const download = '/download';
  static const settings = '/settings';
  static const youtubeConfiguration = '/youtubeConfiguration';
  static const feedConfiguration = '/feedConfiguration';
  static const tools = '/tools';

  static Route<dynamic> routeGenerator(RouteSettings routeSettings) {
    final Map<String, dynamic> args = routeSettings.arguments;

    switch(routeSettings.name) {
      case home:
        return _route(
          builder: HomeView(),
          settings: routeSettings
        );
      case browse:
        if(args != null && args.containsKey('view')) {
          return _route(
            builder: BrowseView(drip: args['view']),
            settings: routeSettings
          );
        }

        return _route(
          builder: BrowseView(),
          settings: routeSettings
        );
        
      case download:
        return _route(
          builder: DownloadView(),
          settings: routeSettings
        );
      case settings:
        return _route(
          builder: SettingsView(),
          settings: routeSettings
        );
      case youtubeConfiguration:
        return _route(
          builder: YoutubeConfigurationView(),
          settings: routeSettings
        );
      case feedConfiguration:
        return _route(
          builder: FeedConfigurationView(),
          settings: routeSettings
        );
      case tools:
        if(args != null && args.containsKey('view')) {
          return _route(
            builder: ToolsView(),
            settings: routeSettings
          );
        }
        
        return _route(
          builder: ToolsView(),
          settings: routeSettings
        );
      default:
        return errorRoute(routeSettings);
      break;
    }
  }

  static CupertinoPageRoute errorRoute(RouteSettings settings) {
    return _route(builder: ErrorView(), settings: settings);
  }

  static CupertinoPageRoute _route({Widget builder, RouteSettings settings}) {
    return CupertinoPageRoute(builder: (_) => builder, settings: settings);
  }
}