import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/views/view.dart';

class HomeView extends View {
  @override
  String get label => 'MediaDrip';
  
  @override
  String get routeAddress => '/';

  @override
  IconData get icon => Icons.home;

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
                header: '$label',
                subHeader: 'MediaDrip currently works by running processes that you have installed on your device. For example, in order to download media, you need to have youtube-dl added to your system variables.'
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