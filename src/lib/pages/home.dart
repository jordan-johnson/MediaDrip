import 'package:flutter/material.dart';
import '../widgets/dripNavigation.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Testing',
            style: Theme.of(context).textTheme.display1,
          )
        ]
      ),
      drawer: DripNavigation(
        items: <DripNavigationItem>[
          DripNavigationItem(label: 'Home', route: 'home'),
          DripNavigationItem(label: 'Download', route: 'download'),
          DripNavigationItem(label: 'Video Tools', route: 'tools'),
          DripNavigationItem(label: 'Settings', route: 'settings')
        ]
      )
    );
  }
}