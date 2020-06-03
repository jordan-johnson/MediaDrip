import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/dripAssets.dart';
import 'package:mediadrip/common/drawer/dripDrawer.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/views/view.dart';

class HomeView extends View {
  @override
  String displayTitle() => 'MediaDrip';

  @override
  String routeAddress() => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(displayTitle()),
        automaticallyImplyLeading: true
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayTitle() + ' vAlpha'),
                Text('MediaDrip currently works by running processes that you have installed on your device. For example, in order to download media, you need to have youtube-dl added to your system variables.'),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: DripAssets.image('mediaDripLogo.png', 384, 128)
            )
          ],
        )
      ),
      drawer: DripDrawer()
    );
  }
}