import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drawer/drip_drawer.dart';
import 'package:mediadrip/common/widgets/drip_app_bar.dart';

class DripWrapper extends StatelessWidget {
  final String title;
  final String route;
  final Widget child;

  DripWrapper({
    @required this.title,
    @required this.route,
    @required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DripAppBar(title: this.title, route: this.route),
      drawer: DripDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: this.child,
      )
    );
  }
}