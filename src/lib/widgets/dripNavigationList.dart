import 'package:flutter/material.dart';
import 'dripNavigationItem.dart';

export 'dripNavigationItem.dart';

class DripNavigationList extends StatelessWidget {
  final List<DripNavigationItem> items;

  const DripNavigationList({
    Key key,
    this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items
    );
  }
}