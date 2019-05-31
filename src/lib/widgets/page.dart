import 'package:flutter/material.dart';
import 'navigation/dripNavigation.dart';

class Page extends StatefulWidget {
  final String title;
  final Widget body;

  Page({
    Key key,
    this.title,
    this.body
  });

  @override
  PageState createState() => PageState(this.body);
}

class PageState extends State<Page> {
  Widget body;

  PageState(Widget body) {
    this.body = body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.body,
      drawer: DripNavigation(
        items: <DripNavigationItem>[
          DripNavigationItem(label: 'Home', route: 'home', icon: Icons.home),
          DripNavigationItem(label: 'Download', route: 'download', icon: Icons.arrow_downward),
          DripNavigationItem(label: 'Video Tools', route: 'tools', icon: Icons.video_library),
          DripNavigationItem(label: 'Settings', route: 'settings', icon: Icons.settings)
        ]
      )
    );
  }
}
/*
abstract class Page extends StatefulWidget {
  final String title;
  Widget body;

  Page([this.title = 'Untitled', this.body]);

  void setBody();

  @override
  PageState createState() => PageState();
}

class PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: widget.body,
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
}*/
/*
abstract class Page extends StatefulWidget {
  String title;
  Widget body;

  Page({
    Key key,
    this.title,
    this.body
  }) : super(key: key);

  @override
  PageState createState() => PageState();
}

class PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: widget.body,
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
}*/