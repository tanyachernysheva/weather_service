import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

final class HttpClient {
  HttpClient._();

  static HttpClient? _httpClient;

  factory HttpClient() {
    return _httpClient ??= HttpClient._();
  }

  Future<dynamic> get({
    required String baseUrl,
    required String path,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(
      baseUrl,
      path,
      query,
    );

    final response = await http.get(uri);

    return convert.jsonDecode(response.body);
  }
}
