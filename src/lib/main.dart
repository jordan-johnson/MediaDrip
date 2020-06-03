import 'package:flutter/material.dart';
import 'package:mediadrip/common/dripRouter.dart';
import 'package:mediadrip/models/downloadModel.dart';
import 'package:mediadrip/views/viewManager.dart';
import 'package:provider/provider.dart';
import 'common/theme.dart';

class MediaDrip extends StatelessWidget {
  final String title = 'MediaDrip';

  final ViewManager _viewManager;
  final DripRouter _router;

  MediaDrip() :
    _viewManager = ViewManager(),
    _router = DripRouter()
  {
    _router.registerRoutes(_viewManager.getViews());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DownloadModel()
        )
      ],
      child: MaterialApp(
        title: this.title,
        theme: AppTheme.getThemeData(),
        debugShowCheckedModeBanner: false,
        home: _viewManager.getView('MediaDrip'),
        onGenerateRoute: _router.getRoutes()
      ),
    );
  }
}

void main() => runApp(MediaDrip());
