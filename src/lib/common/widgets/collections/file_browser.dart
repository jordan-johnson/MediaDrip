import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/filebrowser/index.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:provider/provider.dart';

class FileBrowser extends StatelessWidget {
  FileBrowser() {
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FileBrowserModel>(
      create: (_) => FileBrowserModel(),
      child: Consumer<FileBrowserModel>(
        builder: (_, model, __) {
          // keep working on this to get files in directory
          return FutureBuilder<List<FileEntity>>(
            future: model.getFiles(),
            builder: (BuildContext context, AsyncSnapshot<List<FileEntity>> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                print('done');
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
                print('not done');
                return Container(height: 60, child: Center(child: CircularProgressIndicator()));
              }

              return Container();
            }
          );
        }
      )
    );
  }

  Future<void> _initialize() async {
    
  }
}