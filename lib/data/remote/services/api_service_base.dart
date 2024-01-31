import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perebas_fc_app/config.dart';
import 'package:perebas_fc_app/data/remote/services/auth_service.dart';

abstract class ApiServiceBase {
  final String apiBaseUrl = AppConfig.apiBaseUrl;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();

  ApiServiceBase();

  Future<String> _getToken() async {
    final String? token = await secureStorage.read(key: 'token');
    if (token == null) throw Exception("Token inválido");
    return token;
  }

  Future<dynamic> get(String endpoint) async {
    final String token = await _getToken();

    final response = await http.get(
      Uri.parse('$apiBaseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    switch (response.statusCode) {
      case 200:
        return _decodeResponse(response.body);
      case 401:
        await _authService.logout();
        break;
    }

    throw 'Erro na solicitação: ${response.statusCode}';
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> object) async {
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

    switch (response.statusCode) {
      case 200:
        return _decodeResponse(response.body);
      case 401:
        await _authService.logout();
        break;
    }

    throw 'Erro na solicitação: ${response.statusCode}';
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> object) async {
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

    switch (response.statusCode) {
      case 200:
        return _decodeResponse(response.body);
      case 401:
        await _authService.logout();
        break;
    }

    throw 'Erro na solicitação: ${response.statusCode}';
  }

  Future<dynamic> delete(String endpoint) async {
    final String token = await _getToken();

    final response = await http.delete(Uri.parse('$apiBaseUrl/$endpoint'),
        headers: {'Authorization': 'Bearer $token'});

    switch (response.statusCode) {
      case 200:
        return _decodeResponse(response.body);
      case 401:
        await _authService.logout();
        break;
    }

    throw 'Erro na solicitação: ${response.statusCode}';
  }

  dynamic _decodeResponse(String responseBody) {
    final dynamic decoded = json.decode(responseBody);
    return decoded;
  }
}
