import 'package:flutter/material.dart';

abstract class View extends StatelessWidget {
  String get label;
  String get routeAddress;
  IconData get icon;

  Object routeArguments = List();

  Widget build(BuildContext context);
}