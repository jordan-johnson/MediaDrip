import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/file/folder_item.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/utilities/file_helper.dart';

enum FileBrowserViewType {
  grid,
  list
}

class _FileBrowserModel extends WidgetModel {
  final PathService _pathService = locator<PathService>();

  String _currentFolderPath;

  FolderItem currentFolder;

  FileBrowserViewType viewType;

  _FileBrowserModel({@required this.viewType});

  Future<FolderItem> getFolder() async {
    _currentFolderPath ??= await _pathService.convertDirectoryEnumToPath(AvailableDirectories.downloads);
    currentFolder = await FileHelper.buildFolderContentsFromPath(_currentFolderPath);

    return currentFolder;
  }

  Future<void> updateCurrentFolder(String path) async {
    _currentFolderPath = path;

    notifyListeners();
  }

  void changeViewType(FileBrowserViewType type) {
    viewType = type;

    notifyListeners();
  }
}

class FileBrowser extends StatelessWidget {
  final FileBrowserViewType viewType;

  FileBrowser({@required this.viewType});

  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_FileBrowserModel>(
      model: _FileBrowserModel(viewType: this.viewType),
      builder: (model) {
        return FutureBuilder<FolderItem>(
          future: model.getFolder(),
          builder: (BuildContext context, AsyncSnapshot<FolderItem> snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData) {
                var entities = snapshot.data;
                var folderTiles = List<ListTile>();
                var fileTiles = List<ListTile>();

                for(var folder in entities.subFolders) {
                  var tile = ListTile(
                    leading: Icon(
                      Icons.folder,
                      color: Colors.yellow[200],
                      size: 32
                    ),
                    title: Text(
                      folder.name,
                      style: Theme.of(context).textTheme.headline5
                    ),
                    onTap: () => model.updateCurrentFolder(folder.path),
                  );

                  folderTiles.add(tile);
                }

                for(var file in entities.files) {
                  var tile = ListTile(
                    leading: Icon(
                      FileHelper.getIconFromFileName(file.name),
                      color: Theme.of(context).iconTheme.color,
                      size: 32
                    ),
                    title: Text(
                      file.name,
                      style: Theme.of(context).textTheme.headline5
                    ),
                    subtitle: Text(
                      '${file.sizeConversion}'
                    ),
                  );

                  fileTiles.add(tile);
                }

                return ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Folders'),
                        ListView.separated(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: folderTiles.length,
                          itemBuilder: (ctx, index) {
                            return folderTiles[index];
                          },
                        ),
                        Divider(),
                        Text('Files'),
                        ListView.separated(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: fileTiles.length,
                          itemBuilder: (ctx, index) {
                            return fileTiles[index];
                          },
                        ),
                      ],
                    )
                  ],
                );
              }
            } else {
              return Container(height: 60, child: Center(child: CircularProgressIndicator()));
            }

            return Container();
          },
        );
      },
    );
  }
}