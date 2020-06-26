import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mediadrip/common/models/download_instructions_model.dart';
import 'package:mediadrip/common/models/download_source_model.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/path_service.dart';

class DownloadService {
  final Client _client = http.Client();

  final PathService _pathService = locator<PathService>();

  final String _configFileName = 'youtube-dl.conf';

  Future<String> get _downloadsDirectory async => await _pathService.downloadsDirectory;

  String _configFullPath = '';

  List<DownloadSourceModel> _sources = List<DownloadSourceModel>();

  Future<void> initialize() async {
    var configExists = await _pathService.fileExistsInDirectory(_configFileName, AvailableDirectories.configuration);

    if(!configExists) {
      var getConfigurationAsset = await rootBundle.loadString('lib/assets/$_configFileName');

      getConfigurationAsset = getConfigurationAsset.replaceAll('{directory_to_be_replaced}', await _downloadsDirectory);

      await _pathService.createFileInDirectory(_configFileName, getConfigurationAsset, AvailableDirectories.configuration);
    }

    if(_configFullPath.isEmpty)
      _configFullPath = await _pathService.getPathOfFileInDirectory(_configFileName, AvailableDirectories.configuration);
  }

  void addSource<T extends DownloadSourceModel>(T source) {
    if(source.lookupAddresses == null) {
      throw Exception('Source address canniot be empty');
    }

    _sources.add(source);
  }

  Future<String> getResponseBodyAsString(String address) async {
    var response = await _getResponseIfSuccessful(address);

    if(response == null)
      return null;
    
    return response.body;
  }

  Future<List<int>> getResponseBodyAsBytes(String address) async {
    var response = await _getResponseIfSuccessful(address);

    if(response == null)
      return null;
    
    return response.bodyBytes;
  }

  Future<void> dripToDisk(DripModel drip) async {
    if(!drip.isDownloadableLink || drip.type == DripType.unset)
      return;

    var source = _getSourceByAddressLookup(drip.link);

    if(source != null) {
      print('dripping');
      var instructions = source.configureDownload(drip);

      await _executeInstructions(instructions);
    }
  }

  Future<Response> _getResponseIfSuccessful(String address) async {
    var response = await _client.get(address);

    if(response.statusCode == 200) {
      return response;
    }

    return null;
  }

  DownloadSourceModel _getSourceByAddressLookup(String address) {
    for(var source in _sources) {
      for(var lookup in source.lookupAddresses) {
        if(address.contains(lookup)) {
          return source;
        }
      }
    }

    return null;
  }

  Future<void> _executeInstructions(DownloadInstructionsModel instructions) async {
    await initialize();

    print('execute instruct');

    switch(instructions.type) {
      case DripType.image:
        var fileExtension = _pathService.getExtensionFromFileName(instructions.address);
        var fileName = '${instructions.info}.$fileExtension';
        var bytes = await getResponseBodyAsBytes(instructions.address);

        await _pathService.createFileInDirectoryFromBytes(fileName, bytes, AvailableDirectories.downloads);
      break;
      case DripType.audio:
      case DripType.video:
      default:
        print('why is this not called??');
        print('$_configFullPath');
        await Process.start('youtube-dl', ['${instructions.address}', '--config-location', '$_configFullPath']).then((process) {
          process.stdout
            .transform(utf8.decoder)
            .listen((data) => print(data));
        });
      break;
    }
  }
}