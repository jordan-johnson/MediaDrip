import 'dart:convert';
import 'dart:io';

/// Details the possible states of the [YoutubeDownloaderService].
enum DownloaderState {
  idle,
  updating,
  downloading
}

class YoutubeDownloaderService {
  /// Describes the state of our download service.
  /// 
  /// The state is initialized to [DownloaderState.idle].
  DownloaderState _state = DownloaderState.idle;

  /// Getter for private property [_state] so the state 
  /// cannot be changed outside the service.
  DownloaderState get state => _state;
  
  /// Attempts to update youtube-dl natively or via pip.
  /// 
  /// [messenger] is a callback to describe the process.
  /// 
  /// Refer to [_process] for more information.
  Future<void> update(Function(String) messenger) async {
    _state = DownloaderState.updating;
    
    messenger('Attempting native update...');
    await _process('youtube-dl', ['-U'], messenger);

    messenger('Attempting update via pip...');
    await _process('pip', ['install', '--upgrade', 'youtube-dl'], messenger);

    _state = DownloaderState.idle;
  }

  /// Downloads media using youtube-dl process.
  /// 
  /// [messenger] is a callback to describe the process.
  /// 
  /// [args] is the address to the media.
  /// 
  /// Refer to [_process] for more information.
  Future<void> download(Function(String) messenger, List<String> args) async {
    _state = DownloaderState.downloading;

    await _process('youtube-dl', args, messenger);

    _state = DownloaderState.idle;
  }
  
  /// Starts a process based on [command] with given [args].
  /// 
  /// [messenger] is a callback to describe the process.
  /// 
  /// Currently, there is a 'bug' that is out of my hands. 
  /// On Windows 10, `cmd.exe` is launched to start the 
  /// process. The window is placed in front of the 
  /// application and will disappear when the process is 
  /// finished.
  /// 
  /// I could write an incredibly hacky workaround to hide 
  /// the window, but that's going to be time consuming and 
  /// it will end up breaking in the future.
  Future<void> _process(String command, List<String> args, Function(String) messenger) async {
    await Process.start(command, args).then((process) {
      process.stdout
        .transform(utf8.decoder)
        .listen((data) => messenger(data));
    });
  }
}