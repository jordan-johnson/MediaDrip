import 'dart:convert';
import 'dart:io';
import 'package:mediadrip/common/drawer/dripDrawer.dart';

class DownloadModel extends ChangeNotifier {
  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;

  String _output = '';
  String get getOutput => _output;

  // may need to update this eventually...
  // sudo may also be required
  void update() {
    _setOutput('Attempting to update youtube-dl...');

    Process.start('pip', ['install', '--upgrade', 'youtube-dl']).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => _appendToOutput(data));
      
      process.exitCode.then((value) {
        if(value != 0) {
          _error('Failed to update. Process uses pip; please report this problem with the package manager used to install youtube-dl.');
        }
      });
    });
  }

  void download(List<String> args) {
    _output = '';

    _toggleDownloadStatus();
    
    Process.start('youtube-dl', args, runInShell: false).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => _appendToOutput(data));

      process.exitCode.then((value) {
        if(value != 0) {
          _error('Could not download media. Check that ffmpeg and youtube-dl are installed and added to system variables.');
        } else {
          _appendToOutput('Media downloaded successfully!\n');
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
    final output = (_output.isEmpty) ? message : message + '\n' + _output;
    // final output = (_output.isEmpty) ? message : _output += '\n' + message;

    _setOutput(output);
  }

  void _error(String message) {
    _setOutput(message);
  }
}