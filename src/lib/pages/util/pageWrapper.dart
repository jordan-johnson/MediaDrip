import 'package:flutter/material.dart';
import 'pageDrawer.dart';

class PageWrapper extends StatelessWidget {
  final String title;
  final Widget body;
  final bool enableDrawer;
  
  PageWrapper({
    this.title,
    this.body,
    this.enableDrawer = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // If page title is null, default to MediaDrip
      appBar: AppBar(
        title: (this.title != null) ? Text(this.title) : Text('MediaDrip'),
        automaticallyImplyLeading: true
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            this.body
          ]
        )
      ),
      drawer: (this.enableDrawer) ? PageDrawer() : null
    );
  }
}