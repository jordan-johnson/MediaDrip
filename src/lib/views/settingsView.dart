import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/drawer/dripDrawer.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/views/view.dart';

class SettingsView extends View {
  @override
  String displayTitle() => 'Settings';

  @override
  String routeAddress() => '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('hi world')
          ]
        )
      ),
      drawer: DripDrawer()
    );
  }
}