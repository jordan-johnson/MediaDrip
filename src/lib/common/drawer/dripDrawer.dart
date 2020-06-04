import 'package:flutter/material.dart';
import 'dripDrawerItem.dart';

export 'package:flutter/material.dart'; 
export 'dripDrawerItem.dart';

class DripDrawer extends Drawer {
  final List<DripDrawerItem> items;

  const DripDrawer({
    Key key,
    this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DripDrawerItem(label: 'Home', route: '/', icon: Icons.home),
          DripDrawerItem(label: 'Browse', route: '/browse', icon: Icons.folder),
          DripDrawerItem(label: 'Download', route: '/download', icon: Icons.arrow_downward),
          DripDrawerItem(label: 'Video Tools', route: '/tools', icon: Icons.video_library),
          DripDrawerItem(label: 'Settings', route: '/settings', icon: Icons.settings)
        ],
      )
    );
  }
}