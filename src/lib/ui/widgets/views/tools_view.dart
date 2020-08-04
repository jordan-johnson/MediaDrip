import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/models/file/folder_item.dart';
import 'package:mediadrip/ui/widgets/collections/index.dart';
import 'package:mediadrip/ui/widgets/drip_wrapper.dart';
import 'package:mediadrip/utilities/index.dart';

class ToolsView extends StatelessWidget {
  final FolderItem folder;

  ToolsView({this.folder});

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
      child: Row(
        children: [
          Expanded(
            child: FileBrowser(
              viewType: FileBrowserViewType.grid
            )
          ),
          Expanded(
            child: Column(
              children: [
                Placeholder(),
                Text('ok')
              ],
            )
          )
        ],
      ),
    );
  }
}