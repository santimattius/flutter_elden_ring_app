import 'package:flutter_elden_ring_app/shared/error/exceptions.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String baseUrl;

  ApiClient({required this.client, required this.baseUrl});

  Future<String> get(String path) async {
    final response = await client.get(Uri.parse("$baseUrl/$path"),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ServerException();
    }
  }
}
