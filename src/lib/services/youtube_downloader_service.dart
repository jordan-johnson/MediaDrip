import 'dart:convert';
import 'dart:io';

enum DownloaderState {
  idle,
  updating,
  downloading
}

class YoutubeDownloaderService {
  DownloaderState _state = DownloaderState.idle;
  DownloaderState get state => _state;
  
  int update(Function(String) messenger) {
    _state = DownloaderState.updating;
    int response = 0;

    messenger('Trying update natively...');
    response = _process('youtube-dl', ['-U'], messenger);

    if(response != 0) {
      messenger('Trying update via pip...');
      response = _process('pip', ['install', '--upgrade', 'youtube-dl'], messenger);
    }

    _state = DownloaderState.idle;

    return response;
  }

  void download(Function(String) messenger, List<String> args) {
    _state = DownloaderState.downloading;

    _process('youtube-dl', args, messenger);

    _state = DownloaderState.idle;
  }
  
  int _process(String command, List<String> args, Function(String) messenger) {
    Process.start(command, args).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => messenger(data));

      process.exitCode.then((value) {
        if(value != 0) {
          messenger('Process failure.');
        } else {
          messenger('Process finished successfully!');

          return 0;
        }
      });
    });

    return -1;
  }
}