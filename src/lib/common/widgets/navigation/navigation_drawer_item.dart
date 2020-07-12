import 'package:flutter/material.dart';

class NavigationDrawerItem extends ListTile {
  final String label;
  final String route;
  final IconData icon;

  const NavigationDrawerItem({
    Key key,
    this.label,
    this.route,
    this.icon,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: Icon(this.icon, color: Colors.black),
      onTap: () => Navigator.pushNamed(context, route)
    );
  }
}