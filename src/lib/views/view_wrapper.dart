import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drawer/drip_drawer.dart';
import 'package:mediadrip/common/widgets/drip_app_bar.dart';
import 'package:mediadrip/views/view.dart';

class ViewWrapper extends StatelessWidget {
  final View view;
  final DripDrawer drawer;

  ViewWrapper({@required this.view, @required this.drawer});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DripAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: view.build(context),
      ),
      drawer: drawer
    );
  }
}