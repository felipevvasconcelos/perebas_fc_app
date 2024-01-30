import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perebas_fc_app/config.dart';

abstract class ApiServiceBase<T> {
  final String apiBaseUrl = AppConfig.apiBaseUrl;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ApiServiceBase();

  Future<String> _getToken() async {
    final String? token = await secureStorage.read(key: 'token');
    if (token == null) throw Exception("Token inválido");
    return token;
  }

  Future<T> get(String endpoint) async {
    final String token = await _getToken();

    final response = await http.get(
      Uri.parse('$apiBaseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      return _decodeResponse(response.body);
    } else {
      throw Exception('Erro na solicitação: ${response.statusCode}');
    }
  }

  Future<T> post(String endpoint, T object) async {
    final String token = await _getToken();

    final response = await http.post(
      Uri.parse('$apiBaseUrl/$endpoint'),
      body: jsonEncode(object),
      headers: {
        'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      return _decodeResponse(response.body);
    } else {
      throw Exception('Erro na solicitação: ${response.statusCode}');
    }
  }

  Future<T> put(String endpoint, T object) async {
    final String token = await _getToken();

    final response = await http.put(
      Uri.parse('$apiBaseUrl/$endpoint'),
      body: jsonEncode(object),
      headers: {
        'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      return _decodeResponse(response.body);
    } else {
      throw Exception('Erro na solicitação: ${response.statusCode}');
    }
  }

  Future<T> delete(String endpoint) async {
    final String token = await _getToken();

    final response = await http.delete(Uri.parse('$apiBaseUrl/$endpoint'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return _decodeResponse(response.body);
    } else {
      throw Exception('Erro na solicitação: ${response.statusCode}');
    }
  }

  T _decodeResponse(String responseBody) {
    final dynamic decoded = json.decode(responseBody);
    return decoded;
  }
}
