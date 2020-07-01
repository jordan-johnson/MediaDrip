import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drawer/drip_drawer_item.dart';
import 'package:mediadrip/utilities/routes.dart';

class DripDrawer extends Drawer {

  final List<DripDrawerItem> _items;

  DripDrawer({
    Key key,
  }) : _items = [
      DripDrawerItem(label: 'Home', icon: Icons.home, route: Routes.home,),
      DripDrawerItem(label: 'Browse', icon: Icons.folder, route: Routes.browse,),
      DripDrawerItem(label: 'Download', icon: Icons.arrow_downward, route: Routes.download,),
      DripDrawerItem(label: 'Tools', icon: Icons.video_library, route: Routes.tools,),
      DripDrawerItem(label: 'Settings', icon: Icons.settings, route: Routes.settings,),
    ],
    super(key: key);

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
            for(var item in _items)
              item
          ],
        )
      )
    );
  }
}