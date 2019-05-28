import 'package:flutter/material.dart';
import 'dripNavigationList.dart';

class DripNavigation extends Drawer {
  @override
  Widget build(BuildContext context) {
    return DripNavigationList(
      items: <DripNavigationItem>[
        DripNavigationItem(label: 'Home', route: 'home'),
        DripNavigationItem(label: 'Download', route: 'download'),
        DripNavigationItem(label: 'Video Tools', route: 'tools'),
        DripNavigationItem(label: 'Settings', route: 'settings')
      ]
    );
  }
}