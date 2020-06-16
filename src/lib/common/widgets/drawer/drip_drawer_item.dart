import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/view_state_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/view_manager_service.dart';
import 'package:provider/provider.dart';

class DripDrawerItem extends ListTile {
  final String label;
  final String route;
  final IconData icon;

  const DripDrawerItem({
    Key key,
    this.label,
    this.route,
    this.icon,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var viewService = locator<ViewManagerService>();

    return Consumer<ViewStateModel>(
      builder: (_, model, __) {
        return ListTile(
          title: Text(this.label),
          leading: Icon(this.icon, color: Colors.black),
          onTap: () => viewService.goTo(route)
        );
      }
    );
  }
}