import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class WebDownloadHelper {
  static final Client _client = http.Client();

  static Future<String> getResponseBodyAsString(String address) async {
    var response = await _getResponseIfSuccessful(address);

    if(response == null)
      return null;
    
    return response.body;
  }

  static Future<List<int>> getResponseBodyAsBytes(String address) async {
    var response = await _getResponseIfSuccessful(address);

    if(response == null)
      return null;
    
    return response.bodyBytes;
  }

  static Future<Response> _getResponseIfSuccessful(String address) async {
    var response = await _client.get(address);

    return response.statusCode == 200 ? response : null;
  }
}