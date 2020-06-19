import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mediadrip/common/models/view_state_model.dart';
import 'package:mediadrip/common/widgets/drawer/drip_drawer.dart';
import 'package:mediadrip/views/browse_view.dart';
import 'package:mediadrip/views/download_view.dart';
import 'package:mediadrip/views/home_view.dart';
import 'package:mediadrip/views/settings_view.dart';
import 'package:mediadrip/views/tools_view.dart';
import 'package:mediadrip/views/view.dart';
import 'package:mediadrip/views/view_wrapper.dart';

class ViewManagerService extends StatelessWidget {
  /// Container of views for routing and building. Each [View] requires 
  /// a [View.routeAddress] and [View.build] method for this service 
  /// to work.
  final List<View> _views;

  /// Stores the current view. When [goTo] is called, the view is updated.
  /// 
  /// [ViewStateModel] extends `ChangeNotifier`. Any `Consumer`s of the 
  /// model will be notified of the change.
  final ViewStateModel state = ViewStateModel();

  /// Navigation key that is provided to [MaterialApp.navigatorKey] when 
  /// changes to the route occur.
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  /// This service manages routing and building views, and updating the state 
  /// of our [ViewStateModel] property, [state].
  /// 
  /// Views are initialized in the constructor.
  ViewManagerService() :
    _views = [
      HomeView(),
      BrowseView(),
      DownloadView(),
      ToolsView(),
      SettingsView()
    ];

  /// Loops through all views initialized in [_views], finds the requested 
  /// route address, then returns a [CupertinoPageRoute] to build the view.
  /// 
  /// The [build] method is called and displays the current view found in 
  /// [state].
  /// 
  /// Refer to [build] for more information.
  RouteFactory getRoutes() {
    return (settings) {
      for(var view in _views) {
        if(settings.name == view.routeAddress) {
          view.routeArguments = settings.arguments;
          
          return CupertinoPageRoute(builder: (context) => build(context));
        }
      }

      return null;
    };
  }

  /// Pushes a new [route] with optional [arguments], and updates [state] 
  /// with the new view.
  void goTo(String route, {dynamic arguments}) {
    state.view = _getViewByRoute(route);

    navigationKey.currentState.pushNamed(route, arguments: arguments);
  }

  /// Attempts to go back to our initial route.
  /// 
  /// NOTE: This method only supports surface-level routing. If I decide 
  /// to allow nested routing, this will need to be updated.
  void goBack() {
    if(navigationKey.currentState.canPop()) {
      state.view = _getViewByRoute('/');

      navigationKey.currentState.pop();
    }
  }

  /// Builds the current [View] found in the [ViewStateModel] property, 
  /// [state].
  /// 
  /// First, if [ViewStateModel.view] is null, we're going to update it. 
  /// It's not pretty but it gets the job done until I have a cleaner 
  /// solution.
  /// 
  /// Next, we wrap our [ViewStateModel.view] widget in [ViewWrapper], 
  /// giving it our current state and [DripDrawer].
  /// 
  /// [DripDrawer] requires a collection of views for navigation. The 
  /// reason I provide the entire [View] is that the drawer needs a 
  /// [View.label], [View.routeAddress], and [View.icon]. In other 
  /// languages, I would use an interface; but interfaces are different 
  /// in dart. It's something I'll need to look into for cleaner code.
  @override
  Widget build(BuildContext context) {
    if(state.view == null) {
      state.view = _getViewByRoute('/');
    }

    return ViewWrapper(
      view: state.view,
      drawer: DripDrawer(items: _views)
    );
  }

  /// Returns a view given a matching [route].
  View _getViewByRoute(String route) {
    return _views.firstWhere((x) => x.routeAddress == route);
  }
}