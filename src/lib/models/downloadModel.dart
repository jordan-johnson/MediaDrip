import 'dart:convert';
import 'dart:io';
import 'package:mediadrip/common/drawer/dripDrawer.dart';

class DownloadModel extends ChangeNotifier {
  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;

  String _output = '';
  String get getOutput => _output;

  void download(List<String> args) {
    _output = '';

    _toggleDownloadStatus();
    
    Process.start('youtube-dl', args).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => _appendToOutput(data));

      process.exitCode.then((value) {
        if(value != 0) {
          _error('Could not download video. Check that ffmpeg and youtube-dl are installed and added to system variables.');
        } else {
          _appendToOutput('Video downloaded successfully!');
        }

        _toggleDownloadStatus();
      });
    });
  }

  void _toggleDownloadStatus() {
    _isDownloading = !_isDownloading;

    notifyListeners();
  }

  void _setOutput(String message) {
    _output = message;

    notifyListeners();
  }

  void _appendToOutput(String message) {
    final output = (_output.isEmpty) ? message : _output += '\n' + message;

    _setOutput(output);
  }

  void _error(String message) {
    _setOutput(message);
  }
}