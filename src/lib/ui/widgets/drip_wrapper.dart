import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/ui/widgets/navigation/application_bar.dart';
import 'package:mediadrip/ui/widgets/navigation/navigation_drawer.dart';

class DripWrapper extends StatelessWidget {
  final String title;
  final String route;
  final Widget child;
  final Widget floatingActionButton;
  final List<Widget> appBarActions;

  DripWrapper({
    @required this.title,
    @required this.route,
    @required this.child,
    this.floatingActionButton,
    this.appBarActions
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationBar(title: this.title, route: this.route, actions: appBarActions),
      drawer: NavigationDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: floatingActionButton,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: this.child,
      )
    );
  }
}