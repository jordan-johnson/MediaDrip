import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export 'dripAssets.dart';

abstract class DripPage extends StatelessWidget {
  final String title;
  final String route;
  final List<DripPage> children;
  final Object routeArguments;

  DripPage({
    Key key,
    this.title,
    this.route,
    this.children,
    this.routeArguments
  });

  @protected
  Widget build(BuildContext context);
}