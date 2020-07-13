import 'package:flutter/cupertino.dart';
import 'package:mediadrip/ui/widgets/collections/index.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class ToolsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DripWrapper(
      title: 'Tools',
      route: Routes.tools,
      child: Row(
        children: [
          Expanded(child: FileBrowser()),
          Expanded(child: Text('hello'))
        ],
      ),
    );
  }
}