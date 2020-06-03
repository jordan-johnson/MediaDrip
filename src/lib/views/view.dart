import 'package:flutter/material.dart';

// mixin View on Widget {
//   final String viewTitle = '';
//   final String routeAddress = '';
// }

abstract class View extends StatelessWidget {
  String displayTitle();
  String routeAddress();
}