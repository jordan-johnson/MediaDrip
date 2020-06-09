import 'package:flutter/material.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/views/models/view_state_model.dart';
import 'package:mediadrip/views/view_manager.dart';
import 'package:mediadrip/services/navigation_service.dart';
import 'package:provider/provider.dart';

class MediaDrip extends StatelessWidget {
  final String title = 'MediaDrip';
  final ViewManager _viewManager = ViewManager();
  final NavigationService _navigationService = NavigationService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ViewStateModel()
        ),
        ProxyProvider<ViewStateModel, NavigationService>(
          update: (_, viewModel, __) {
            _navigationService.viewStateModel = viewModel;

            return _navigationService;
          }
        )
      ],
      child: MaterialApp(
        title: this.title,
        theme: AppTheme.getThemeData(),
        debugShowCheckedModeBanner: false,
        home: _viewManager.getView(context, title),
        onGenerateRoute: _viewManager.getRoutes(),
        navigatorKey: _navigationService.navigatorKey
      )
    );
  }
}

void main() => runApp(MediaDrip());
