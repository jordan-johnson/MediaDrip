import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/file/file_entity.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';
import 'package:mediadrip/ui/widgets/collections/index.dart';

enum FileBrowserViewType {
  grid,
  list
}

class _FileBrowserModel extends WidgetModel {
  final PathService _pathService = locator<PathService>();

  StructuredFileEntities _files;
  StructuredFileEntities get files => _files;

  FileBrowserViewType viewType;

  _FileBrowserModel({@required this.viewType}) {
    getFiles();
  }

  Future<StructuredFileEntities> getFiles() async {
    files = await _pathService.getAllFilesInDirectory(AvailableDirectories.downloads);

    return files;
  }

  set files(StructuredFileEntities value) {
    _files = value;

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
        return FutureBuilder<StructuredFileEntities>(
          future: model.getFiles(),
          builder: (BuildContext context, AsyncSnapshot<StructuredFileEntities> snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData) {
                var entities = snapshot.data;
                var tiles = List<ListTile>();

                // for(var folder in entities.folders) {
                //   var tile = ListTile(
                //     leading: Icon(
                //       Icons.folder,
                //       color: Colors.yellow[200],
                //       size: 32
                //     ),
                //     title: Text(
                //       folder.name,
                //       style: Theme.of(context).textTheme.headline5
                //     )
                //   );

                //   tiles.add(tile);
                // }

                // for(var file in entities.files) {
                //   var tile = ListTile(
                //     leading: Icon(
                //       Icons.insert_drive_file,
                //       color: Colors.yellow[200],
                //       size: 32
                //     ),
                //     title: Text(
                //       file.name,
                //       style: Theme.of(context).textTheme.headline5
                //     )
                //   );

                //   tiles.add(tile);
                // }

                // return ListView(
                //   children: [
                //     for(var tile in tiles)
                //       tile
                //   ],
                // );
                
                // return GridView.builder(
                //   itemCount: entities.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 3 : 2,
                //     crossAxisSpacing: 5,
                //     childAspectRatio: 500 / 300
                //   ),
                //   itemBuilder: (_, index) {
                //     entities.
                //     return Card(
                //       child: Text(entities[index].name),
                //     );
                //   }
                // );
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