import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drawer/drip_drawer_item.dart';
import 'package:mediadrip/views/view.dart';

class DripDrawer extends Drawer {
  final List<View> items;

  const DripDrawer({
    Key key,
    this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/mediaDripLogo.gif'),
                  fit: BoxFit.scaleDown
                )
              ),
              child: Text(''),
            ),
            for(var item in items)
              DripDrawerItem(label: item.label, route: item.routeAddress, icon: item.icon)
          ],
        )
      )
    );
  }
}