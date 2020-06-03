import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrip/common/drawer/dripDrawer.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/models/downloadModel.dart';
import 'package:mediadrip/views/view.dart';
import 'package:provider/provider.dart';

class DownloadView extends View {
  @override
  String displayTitle() => 'Download';

  @override
  String routeAddress() => '/download';

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Please enter a URL...'
              )
            ),
            Consumer<DownloadModel>(
              builder: (context, model, child) {
                final buttonLabel = model.isDownloading ? 'Wait...' : 'Download';

                return RaisedButton(
                  child: Text(buttonLabel),
                  onPressed: (model.isDownloading) ? null : () => model.download([_inputController.text])
                );
              }
            ),
            Consumer<DownloadModel>(
              builder: (context, model, child) {
                _outputController.text = model.getOutput;
                _outputController.selection = TextSelection.fromPosition(TextPosition(offset: _outputController.text.length));

                return TextField(
                  controller: _outputController,
                  maxLines: 8,
                  // enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.deepPurple[50],
                    filled: true,
                  ),
                );
              },

            ),
          ]
        )
      ),
      drawer: DripDrawer()
    );
  }
}