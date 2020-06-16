import 'package:flutter/material.dart';

class DripListItemCollection extends StatelessWidget {
  final String header;
  final IconData icon;
  final List<Widget> children;

  const DripListItemCollection({
    Key key,
    this.header,
    this.icon,
    this.children
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.purple[50],
            child: ListTile(
              leading: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 32
              ),
              title: Text(
                this.header,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          for(var child in this.children)
            child
        ]
      )
    );
  }
}