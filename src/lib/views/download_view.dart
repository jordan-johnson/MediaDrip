import 'package:flutter/material.dart';
import 'package:mediadrip/common/theme.dart';
import 'package:mediadrip/views/view.dart';
import 'package:mediadrip/views/models/download_view_model.dart';
import 'package:provider/provider.dart';

class DownloadView extends View {
  @override
  String get label => 'Download';
  
  @override
  String get routeAddress => '/download';

  @override
  IconData get icon => Icons.arrow_downward;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DownloadViewModel>(
      create: (_) => DownloadViewModel(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTheme.header(Icons.cloud_download, 'Download Media', 'Downloading without issue requires both ffmpeg and youtube-dl to be installed and added to your system variables'),
                    Consumer<DownloadViewModel>(
                      builder: (_, model, __) {
                        return TextFormField(
                          controller: model.inputController,
                          decoration: InputDecoration(
                            hintText: 'Please enter a URL...'
                          ),
                          onFieldSubmitted: (value) => model.download(value)
                        );
                      }
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Consumer<DownloadViewModel>(
                            builder: (context, model, child) {
                              return RaisedButton(
                                child: Text('Update youtube-dl'),
                                onPressed: () => model.update()
                              );
                            }
                          ),
                          SizedBox(width: 20),
                          Consumer<DownloadViewModel>(
                            builder: (context, model, child) {
                              return RaisedButton(
                                child: Text(model.downloadButtonLabel),
                                onPressed: model.isDownloadServiceRunning ? null : () => model.download()
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<DownloadViewModel>(
                  builder: (context, model, child) {
                    // _outputController.text = model.getOutput;
                    // _outputController.selection = TextSelection.fromPosition(TextPosition(offset: _outputController.text.length));

                    return TextField(
                      controller: model.outputController,
                      maxLines: 8,
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.deepPurple[50],
                        filled: true,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}