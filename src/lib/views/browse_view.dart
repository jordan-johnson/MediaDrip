import 'package:flutter/material.dart';
import 'package:mediadrip/views/view.dart';

class BrowseView extends View {
  @override
  String get label => 'Browse';
  
  @override
  String get routeAddress => '/browse';

  @override
  IconData get icon => Icons.folder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Text('Unavailable. Currently waiting on a stable crossplatform file picker.')
    );
  }
}