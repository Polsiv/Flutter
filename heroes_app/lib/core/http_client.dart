import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  final http.Client _client;

  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> getJson(Uri uri) async {
    final resp = await _client.get(uri);
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return json.decode(utf8.decode(resp.bodyBytes));
    }
    throw Exception('GET ${uri.toString()} : ${resp.statusCode}');
  }
}
