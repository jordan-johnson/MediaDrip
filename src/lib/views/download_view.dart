import 'package:flutter/material.dart';
import 'package:mediadrip/common/widgets/drip_header.dart';
import 'package:mediadrip/views/providers/view_model_provider.dart';
import 'package:mediadrip/views/view.dart';
import 'package:mediadrip/views/models/download_view_model.dart';

class DownloadView extends View {
  @override
  String get label => 'Download';
  
  @override
  String get routeAddress => '/download';

  @override
  IconData get icon => Icons.arrow_downward;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DownloadViewModel>(
      model: DownloadViewModel(context: context),
      builder: (model) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                      DripHeader(
                        icon: icon,
                        header: 'Let\'s start dripping.',
                        subHeader: 'Downloading without issue requires both ffmpeg and youtube-dl to be installed and added to your system variables.'
                      ),
                      TextFormField(
                        controller: model.inputController,
                        decoration: InputDecoration(
                          hintText: 'Please enter a URL...'
                        ),
                        onFieldSubmitted: (value) => model.download(value),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.autorenew),
                              iconSize: 24,
                              color: Theme.of(context).primaryColor,
                              onPressed: () => model.update(),
                            ),
                            RaisedButton(
                              child: Text(model.downloadButtonLabel),
                              onPressed: model.isDownloadServiceRunning ? null : () => model.download(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    controller: model.outputController,
                    maxLines: 8,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.deepPurple[50],
                      filled: true,
                    ),
                  ),
                ),
              ],
            )
          )
        );
      },
    );
  }
}