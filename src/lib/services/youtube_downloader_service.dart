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
  
  Future<void> update(Function(String) messenger) async {
    _state = DownloaderState.updating;
    
    messenger('Attempting native update...');
    await _process('youtube-dl', ['-U'], messenger);

    messenger('Attempting update via pip...');
    await _process('pip', ['install', '--upgrade', 'youtube-dl'], messenger);

    _state = DownloaderState.idle;
  }

  Future<void> download(Function(String) messenger, List<String> args) async {
    _state = DownloaderState.downloading;

    _process('youtube-dl', args, messenger);

    _state = DownloaderState.idle;
  }
  
  Future<void> _process(String command, List<String> args, Function(String) messenger) async {
    await Process.start(command, args).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => messenger(data));
    });
  }
}