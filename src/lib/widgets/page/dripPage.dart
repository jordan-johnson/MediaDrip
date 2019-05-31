import 'package:flutter/material.dart';

abstract class DripPage extends StatefulWidget {
  final String route;
  final List<DripPage> children;

  DripPage({
    Key key,
    this.route,
    this.children
  }) : super(key: key);

  @protected
  Widget build(BuildContext context);

  @override
  DripState createState() => DripState();
}

class DripState extends State<DripPage> {
  @override
  Widget build(BuildContext context) => widget.build(context);
}