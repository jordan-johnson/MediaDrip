import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/views/view.dart';

class ToolsView extends View {
  @override
  String get label => 'Tools';
  
  @override
  String get routeAddress => '/tools';

  @override
  IconData get icon => Icons.video_library;

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
                header: 'Modify your drips.',
                subHeader: 'Currently unavailable until a crossplatform file picker is supported.'
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