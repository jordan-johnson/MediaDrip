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
      appBar: AppBar(
        title: Text('MediaDrip'),
        automaticallyImplyLeading: true
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Render optional title
            (this.title != null) ? Column(
              children: <Widget>[
                Text(
                  this.title,
                  style: Theme.of(context).textTheme.display1
                ),
                Divider(color: Colors.deepPurple)
              ],
            ) : null,
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: this.body
            )
          /// REQUIRED
          /// If the title isn't found and this line isn't present,
          /// then exceptions will be thrown
          ]..removeWhere((widget) => widget == null),
        )
      ),
      drawer: (this.enableDrawer) ? PageDrawer() : null
    );
  }
}