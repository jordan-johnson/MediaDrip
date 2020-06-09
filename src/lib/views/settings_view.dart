import 'package:flutter/material.dart';
import 'package:mediadrip/views/view.dart';

class SettingsView extends View {
  @override
  String get label => 'Settings';
  
  @override
  String get routeAddress => '/settings';

  @override
  IconData get icon => Icons.settings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Text('settings')
    );
  }
}