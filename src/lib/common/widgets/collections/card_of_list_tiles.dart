import 'package:flutter/material.dart';

class CardOfListTiles extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  CardOfListTiles({
    this.title,
    this.icon,
    this.children
  });

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
                this.title,
                style: Theme.of(context).textTheme.headline5,
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