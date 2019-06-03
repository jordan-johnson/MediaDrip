import 'package:flutter/material.dart';
import 'pages/pages.dart';
import 'widgets/navigation/dripRouting.dart';

class MediaDrip extends StatelessWidget {
  final String title = 'MediaDrip';

  /// DripRouting relies on a Page Manager that contains
  /// a list of pages and their routes.
  final DripRouting _router = DripRouting(Pages());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: _router.getRoot(),
      onGenerateRoute: _router.getRoutes(),
    );
  }
}

void main() => runApp(MediaDrip());
