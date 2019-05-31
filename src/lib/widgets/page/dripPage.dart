import 'package:flutter/material.dart';

class DripPage extends StatefulWidget {
  final String route;
  final Widget body;
  final List<DripPage> children;

  DripPage({
    Key key,
    this.route,
    this.body,
    this.children
  }) : super(key: key);

  @override
  DripState createState() => DripState();
}

class DripState extends State<DripPage> {
  @override
  Widget build(BuildContext context) {
    return widget.body;
  }
}