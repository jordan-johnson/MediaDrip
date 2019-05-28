import 'package:flutter/material.dart';
import 'dripNavigationItem.dart';

export 'dripNavigationItem.dart';

class DripNavigation extends Drawer {
  final List<DripNavigationItem> items;

  const DripNavigation({
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