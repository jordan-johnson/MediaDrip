import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/views/view.dart';

class BrowseView extends View {
  @override
  String get label => 'Browse';
  
  @override
  String get routeAddress => '/browse';

  @override
  IconData get icon => Icons.folder;

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
                header: 'Browsing drips...',
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