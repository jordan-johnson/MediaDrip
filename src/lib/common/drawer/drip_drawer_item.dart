import 'package:flutter/material.dart';
import 'package:mediadrip/services/navigation_service.dart';
import 'package:mediadrip/views/models/view_state_model.dart';
import 'package:provider/provider.dart';

class DripDrawerItem extends ListTile {
  final String label;
  final String route;
  final IconData icon;

  const DripDrawerItem({
    Key key,
    this.label,
    this.route,
    this.icon
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ViewStateModel>(
      builder: (_, model, __) {
        return ListTile(
          title: Text(this.label),
          leading: Icon(this.icon, color: Colors.black),
          onTap: () {
            var navigator = Provider.of<NavigationService>(context, listen: false);
            navigator.goTo(label, route);
          }
        );
      }
    );
  }
}