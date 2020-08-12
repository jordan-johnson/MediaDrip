import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/models/file/download_instructions.dart';
import 'package:mediadrip/models/file/drip.dart';
import 'package:mediadrip/models/source/download_source.dart';
import 'package:mediadrip/services/index.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/utilities/file_helper.dart';

class DownloadService {
  /// Http client used in downloading from web
  final Client _client = http.Client();

  /// [SettingsService] for any download settings required for service.
  final SettingsService _settingsService = locator<SettingsService>();

  /// [PathService] for downloading to correct directory, validating file names, etc.
  final PathService _pathService = locator<PathService>();

  /// File used in configuring youtube-dl.
  /// 
  /// This will be located in the configuration directory. Refer to [PathService] for 
  /// more information.
  final String _configFileName = 'youtube-dl.conf';

  /// Returns the path to the downloads directory.
  Future<String> get _downloadsDirectory async => await _pathService.downloadsDirectory;

  /// Set by [initialize] to contain the full path to our youtube-dl configuration file.
  String _configFullPath = '';

  /// Sources stored that will return [DownloadInstructionsModel] when an address matches 
  /// one of the lookup addresses.
  List<DownloadSource> _sources = List<DownloadSource>();

  /// Checks if the youtube-dl configuration exists. If it doesn't exist, one will be 
  /// created from the template found in assets.
  /// 
  /// This method is called every time a download is requested. Refer to 
  /// [_executeInstructions] for more information.
  Future<void> initialize() async {
    var configExists = await _pathService.fileExistsInDirectory(_configFileName, AvailableDirectories.configuration);

    if(!configExists) {
      var getConfigurationAsset = await rootBundle.loadString('lib/assets/$_configFileName');

      getConfigurationAsset = getConfigurationAsset.replaceAll('{directory_to_be_replaced}', await _downloadsDirectory);

      await _pathService.createFileInDirectory(_configFileName, getConfigurationAsset, AvailableDirectories.configuration);
    }

    if(_configFullPath.isEmpty) {
      var file = await _pathService.getFileFromFileName(_configFileName, AvailableDirectories.configuration);
      
      _configFullPath = file.path;
    }

    if(_settingsService.data.updateYoutubeDLOnDownload) {
      await updateYoutubeDownloader();
    }
  }

  /// Adds a source to the service. Source MUST extend [DownloadSourceModel].
  /// 
  /// If the lookupAddresses property isn't set, an exception will be thrown.
  void addSource<T extends DownloadSource>(T source) {
    if(source.lookupAddresses == null) {
      throw Exception('Lookup addresses cannot be empty.');
    }

    _sources.add(source);
  }

  /// Reads content of youtube configuration file.
  Future<String> readContentsOfConfiguration() async {
    var configFile = await _pathService.getFileFromFileName(_configFileName, AvailableDirectories.configuration);
    var contents = await configFile.readAsString();

    return contents;
  }

  /// Calls [_getResponseIfSuccessful] to return a response. On success, the response 
  /// body is returned as a string.
  Future<String> getResponseBodyAsString(String address) async {
    var response = await _getResponseIfSuccessful(address);

    if(response == null)
      return null;
    
    return response.body;
  }

  /// Calls [_getResponseIfSuccessful] to return a response. On success, the response 
  /// body is returned as bytes.
  Future<List<int>> getResponseBodyAsBytes(String address) async {
    var response = await _getResponseIfSuccessful(address);

    if(response == null)
      return null;
    
    return response.bodyBytes;
  }

  /// Call this method with a given [DripModel] to download the drip.
  /// 
  /// The [DripModel.link] is checked by [_getSourceByAddressLookup] to see if it 
  /// contains a lookupAddress within [_sources]. If a source is found, we then 
  /// call [DownloadSourceModel.configureDownload] to return instructions on how to 
  /// download the [DripModel] properly.
  /// 
  /// The [DownloadInstructionsModel] is important in determining the correct procedure 
  /// for handling a [DripModel]. For example, you may have a Reddit source that can 
  /// provide audio, video, and image drips. This provides an extra layer in case a 
  /// [DripModel.image] is a video thumbnail and the video is what we need to download, 
  /// or we need to reroute a given [DripModel.link] that is 
  /// https://imgur.com/imagePage to https://i.imgur.com/image.jpg
  Future<void> dripToDisk(Drip drip) async {
    if(!drip.isDownloadableLink || drip.type == DripType.unset)
      return;

    var source = _getSourceByAddressLookup(drip.link);

    if(source != null) {
      var instructions = source.configureDownload(drip);

      await _executeInstructions(instructions);
    }
  }

  /// Provides instructions to [_executeInstructions] to try downloading via Youtube-DL.
  Future<void> downloadUsingYoutubeDownloader(String address) async {
    var instructions = DownloadInstructions(address: address, type: DripType.unset, fileName: null);

    await _executeInstructions(instructions);
  }

  /// This needs to be changed in the future to support package managers.
  Future<void> updateYoutubeDownloader() async {
    await Process.start('youtube-dl', ['-U', '-q']);
  }

  /// Sends a GET request to our http client [_client] and awaits a response.
  /// 
  /// If the response's status code is 200 (OK) then return the response. This will then
  /// be used by [getResponseBodyAsString] or [getResponseBodyAsBytes] to return the body.
  Future<Response> _getResponseIfSuccessful(String address) async {
    var response = await _client.get(address);

    if(response.statusCode == 200) {
      return response;
    }

    return null;
  }

  /// Loops through [_sources] to see if our [address] contains a lookup address.
  /// 
  /// If source is found, return it. Otherwise, return null.
  DownloadSource _getSourceByAddressLookup(String address) {
    for(var source in _sources) {
      for(var lookup in source.lookupAddresses) {
        if(address.contains(lookup)) {
          return source;
        }
      }
    }

    return null;
  }

  /// Executes [DownloadInstructionsModel] to download a given link based on its [DripType].
  /// 
  /// [initialize] is called beforehand to make sure our youtube-dl configuration exists.
  /// 
  /// Next, we determine the type. If the type is an image, we download the content using 
  /// [getResponseBodyAsBytes]. Otherwise, we will use the youtube-dl process to download 
  /// the media.
  /// 
  /// ***IMPORTANT***:
  /// 
  /// When I do not include the -q (quiet) flag to suppress status messages, the process 
  /// seems to halt and doesn't download the file. Perhaps the process crashes when it can't 
  /// write to the shell? Only tested on Windows 10.
  /// 
  /// If you need to write to shell, remove the -q argument and attach the following to 
  /// the await:
  /// 
  /// ```dart
  /// .then((process) {
  ///   process.stdout
  ///     .transform(utf8.decoder)
  ///     .listen((data) => print(data));
  /// });
  /// ```
  Future<void> _executeInstructions(DownloadInstructions instructions) async {
    await initialize();

    switch(instructions.type) {
      case DripType.image:
        var fileExtension = FileHelper.getExtensionFromFileName(instructions.address);
        var fileName = '${instructions.fileName}.$fileExtension';
        var bytes = await getResponseBodyAsBytes(instructions.address);

        await _pathService.createFileInDirectoryFromBytes(fileName, bytes, AvailableDirectories.downloads);
      break;
      case DripType.unset:
      case DripType.audio:
      case DripType.video:
      default:
        await Process.start('youtube-dl', ['${instructions.address}', '-q', '--config-location', '$_configFullPath']);
      break;
    }
  }
}