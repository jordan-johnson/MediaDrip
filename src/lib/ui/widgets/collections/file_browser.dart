import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/ui/providers/widget_provider.dart';

class _FileBrowserModel extends WidgetModel {
  final PathService _pathService = locator<PathService>();

  Future<List<FileEntity>> getFiles() async {
    var files = await _pathService.getAllFilesInDirectory(AvailableDirectories.downloads);

    return files;
  }
}

class FileBrowser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetProvider<_FileBrowserModel>(
      model: _FileBrowserModel(),
      builder: (model) {
        return FutureBuilder<List<FileEntity>>(
          future: model.getFiles(),
          builder: (BuildContext context, AsyncSnapshot<List<FileEntity>> snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData) {
                var entities = snapshot.data;
                
                return GridView.builder(
                  itemCount: entities.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 3 : 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 500 / 300
                  ),
                  itemBuilder: (_, index) {
                    return Card(
                      child: Text(entities[index].name),
                    );
                  }
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