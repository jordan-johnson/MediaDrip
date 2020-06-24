import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mediadrip/common/models/download_source_model.dart';
import 'package:mediadrip/common/models/drip_model.dart';
import 'package:mediadrip/locator.dart';
import 'package:mediadrip/services/path_service.dart';
import 'package:mediadrip/services/settings_service.dart';

class DownloadService {
  final Client _client = http.Client();

  final PathService _pathService = locator<PathService>();

  final SettingsService _settingsService = locator<SettingsService>();

  final String _configFileName = 'youtube-dl.conf';

  String _downloadsDirectory = '';

  String _configFullPath = '';

  List<DownloadSourceModel> _sources = List<DownloadSourceModel>();

  Future<void> initialize() async {
    var configExists = await _pathService.fileExistsInDirectory(_configFileName, AvailableDirectories.configuration);
    _downloadsDirectory = await _pathService.downloadsDirectory;

    if(!configExists) {
      var getYoutubeDLAsset = await rootBundle.loadString('lib/assets/$_configFileName');

      getYoutubeDLAsset = getYoutubeDLAsset.replaceAll('{directory_to_be_replaced}', _downloadsDirectory.replaceAll('\\', '/'));

      await _pathService.createFileInDirectory(_configFileName, getYoutubeDLAsset, AvailableDirectories.configuration);
    }

    var file = await _pathService.getFileInDirectory(_configFileName, AvailableDirectories.configuration);
    _configFullPath = file.path.replaceAll('\\', '\\\\');
  }

  void addSource<T extends DownloadSourceModel>(T source) {
    if(source.sourceAddress.isEmpty) {
      throw Exception('Source address canniot be empty');
    }

    _sources.add(source);
  }

  Future<String> get(String address) async {
    var response = await _client.get(address);
    
    if(response.statusCode == 200) {
      return response.body;
    }

    return null;
  }

  Future<Uint8List> getBytes(String address) async {
    try {
      var response = await _client.get(address);

      if(response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch(Exception) {
      return null;
    }

    return null;
  }

  Future<void> saveDripToDisk(DripModel drip) async {
    print('called');

    if(!drip.isDownloadableLink)
      return;

    if(drip.type == DripType.video) {
      print('$_configFullPath');
      await Process.start('youtube-dl', ['${drip.link}', '--config-location', '$_configFullPath']).then((process) {
        process.stdout
          .transform(utf8.decoder)
          .listen((data) => print(data));
      });
    }

    // var source = _sources.firstWhere((x) => drip.link.contains(x.sourceAddress));

    // if(source != null) {
    //   await source.download(drip);
    // }
  }
}