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
      child: ListView(children: items)
    );
  }
}