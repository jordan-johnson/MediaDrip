import 'package:flutter/material.dart';
import 'pageDrawer.dart';

class PageWrapper extends StatelessWidget {
  final Widget body;
  final bool enableDrawer;
  PageWrapper({
    this.body, 
    this.enableDrawer = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MediaDrip'),
        automaticallyImplyLeading: true
      ),
      body: this.body,
      drawer: (this.enableDrawer) ? PageDrawer() : null
    );
  }
}