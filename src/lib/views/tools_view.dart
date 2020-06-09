import 'package:flutter/material.dart';
import 'package:mediadrip/views/view.dart';

class ToolsView extends View {
  @override
  String get label => 'Tools';
  
  @override
  String get routeAddress => '/tools';

  @override
  IconData get icon => Icons.video_library;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Text('tools!')
    );
  }
}