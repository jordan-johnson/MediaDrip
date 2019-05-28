import 'package:flutter/material.dart';

class DripNavigationItem extends ListTile {
  final String label;
  final String route;

  const DripNavigationItem({
    Key key,
    this.label,
    this.route
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.label)
    );
  }
}