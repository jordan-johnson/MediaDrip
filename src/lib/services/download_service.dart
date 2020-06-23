import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mediadrip/common/models/download_source_model.dart';

class DownloadService {
  final Client _client = http.Client();

  List<DownloadSourceModel> _sources = List<DownloadSourceModel>();

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
}