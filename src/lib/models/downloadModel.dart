import 'dart:convert';
import 'dart:io';

import 'package:mediadrip/common/drawer/dripDrawer.dart';

class DownloadModel extends ChangeNotifier {
  String _output = '';
  String get getOutput => _output;

  void _appendToOutput(String message) {
    _output += (_output.isEmpty) ? message : '\n' + message;

    notifyListeners();
  }

  void download(List<String> args) {
    _output = '';
    
    Process.start('youtube-dl', args).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => _appendToOutput(data)
      );
    });
  }
}