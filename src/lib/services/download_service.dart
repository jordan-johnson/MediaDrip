import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class DownloadService {
  final Client _client = http.Client();

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