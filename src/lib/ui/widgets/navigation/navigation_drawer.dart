import 'package:flutter/material.dart';
import 'package:mediadrip/ui/widgets/navigation/navigation_drawer_item.dart';
import 'package:mediadrip/utilities/routes.dart';

class NavigationDrawer extends Drawer {
  final List<NavigationDrawerItem> _items;

  NavigationDrawer({
    Key key,
  }) : _items = [
      NavigationDrawerItem(label: 'Home', icon: Icons.home, route: Routes.home,),
      NavigationDrawerItem(label: 'Browse', icon: Icons.folder, route: Routes.browse,),
      NavigationDrawerItem(label: 'Download', icon: Icons.arrow_downward, route: Routes.download,),
      NavigationDrawerItem(label: 'Tools', icon: Icons.video_library, route: Routes.tools,),
      NavigationDrawerItem(label: 'Settings', icon: Icons.settings, route: Routes.settings,),
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