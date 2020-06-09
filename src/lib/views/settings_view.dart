import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/views/view.dart';

class SettingsView extends View {
  @override
  String get label => 'Settings';
  
  @override
  String get routeAddress => '/settings';

  @override
  IconData get icon => Icons.settings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DripHeader(
                icon: icon,
                header: 'Modify your settings.',
                subHeader: 'Coming soon!'
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // child: DripAssets.image('mediaDripLogo.png', 384, 128)
          )
        ],
      )
    );
  }
}