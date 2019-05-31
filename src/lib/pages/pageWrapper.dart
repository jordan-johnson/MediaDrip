import 'package:flutter/material.dart';

import '../widgets/navigation/dripNavigation.dart';

class PageWrapper extends StatelessWidget {
  final Widget _body;
  PageWrapper(this._body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MediaDrip')
      ),
      body: this._body,
      drawer: DripNavigation(
        items: <DripNavigationItem>[
          DripNavigationItem(label: 'Home', route: 'home', icon: Icons.home),
          DripNavigationItem(label: 'Download', route: 'download', icon: Icons.arrow_downward),
          DripNavigationItem(label: 'Video Tools', route: 'tools', icon: Icons.video_library),
          DripNavigationItem(label: 'Settings', route: 'settings', icon: Icons.settings)
        ]
      ),
    );
  }
}