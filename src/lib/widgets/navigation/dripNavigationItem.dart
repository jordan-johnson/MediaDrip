import 'package:flutter/material.dart';

class DripNavigationItem extends ListTile {
  final String label;
  final String route;
  final IconData icon;

  const DripNavigationItem({
    Key key,
    this.label,
    this.route,
    this.icon
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.label),
      leading: Icon(this.icon, color: Colors.black),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/' + this.route);
      }
    );
  }
}