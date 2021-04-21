import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/ui/widgets/collections/index.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class ToolsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DripWrapper(
      title: 'Tools',
      route: Routes.tools,
      appBarActions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: '',
                child: Text('Convert')
              ),
              PopupMenuItem<String>(
                value: '',
                child: Text('Stuff')
              ),
              PopupMenuItem<String>(
                value: '',
                child: Text('Test')
              ),
            ];
          },
        )
      ],
      child: Column()
    );
  }
}