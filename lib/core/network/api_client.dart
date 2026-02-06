import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParameters,
    String language = 'en-US',
  }) async {
    final params = {
      'api_key': ApiConstants.apiKey,
      'language': language,
      ...?queryParameters,
    };

    final uri = Uri.parse(
      '${ApiConstants.baseUrl}$endpoint',
    ).replace(queryParameters: params);

    try {
      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${ApiConstants.accessToken}',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          'Failed to load data: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
