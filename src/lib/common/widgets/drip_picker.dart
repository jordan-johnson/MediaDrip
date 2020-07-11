import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/models/drip_picker_model.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:provider/provider.dart';

class DripPicker extends StatelessWidget {

  DripPicker() {
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DripPickerModel>(
      create: (_) => DripPickerModel(),
      child: Consumer<DripPickerModel>(
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
                  // return GridView.count(
                  //   crossAxisCount: 2,
                  //   shrinkWrap: true,
                  //   children: List.generate(entities.length, (index) {
                  //     return SizedBox(
                  //       height: 200,
                  //       child: Card(
                  //         child: Text(entities[index].path),
                  //       ),
                  //     );
                  //   })
                  // );
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