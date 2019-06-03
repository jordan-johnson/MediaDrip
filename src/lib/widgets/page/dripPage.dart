import 'package:flutter/material.dart';
export 'package:flutter/material.dart';

abstract class DripPage extends StatelessWidget {
  final String route;
  final List<DripPage> children;
  final Object routeArguments;

  DripPage({
    Key key,
    this.route,
    this.children,
    this.routeArguments
  });

  @protected
  Widget build(BuildContext context);
}