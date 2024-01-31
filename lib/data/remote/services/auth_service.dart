import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:perebas_fc_app/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:perebas_fc_app/domain/models/error/error_response.dart';
import 'package:perebas_fc_app/domain/models/player/player.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perebas_fc_app/domain/models/auth/auth_response.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final String apiBaseUrl = AppConfig.apiBaseUrl;

  AuthService();

  Future<bool> authenticate(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/auth'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    if (response.statusCode != 200) return false;

    await login(response.body);

    return true;
  }

  Future<bool> register(PlayerModel player, BuildContext context) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/auth/register'),
      body: jsonEncode(player.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    if (response.statusCode != 200) {
      if (json.decode(response.body) is Map<String, dynamic>) {
        ErrorResponseModel error = ErrorResponseModel.fromJson(
          json.decode(response.body),
        );
        throw error.errors[error.errors.keys.first];
      }
      throw json.decode(response.body);
    }

    await login(response.body);

    return true;
  }

  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'token_expiration');
    await storage.delete(key: 'id');
    await storage.delete(key: 'email');
    await storage.delete(key: 'name');
    await storage.delete(key: 'nickname');
    await storage.delete(key: 'position');
  }

  Future login(String token) async {
    final AuthResponseModel auth =
        AuthResponseModel.fromJson(json.decode(token));

    Map<String, dynamic> tokenProps = JwtDecoder.decode(auth.accessToken);
    final PlayerModel player = PlayerModel.fromJson(tokenProps);

    await storage.write(key: 'token', value: auth.accessToken);
    await storage.write(
      key: 'token_expiration',
      value: DateFormat('dd/MM/yyyy HH:mm').format(auth.expiration),
    );

    await storage.write(key: 'id', value: player.id?.toString());
    await storage.write(key: 'email', value: player.email);
    await storage.write(key: 'name', value: player.name);
    await storage.write(key: 'nickname', value: player.nickname);
    await storage.write(key: 'position', value: player.position);
  }

  Future forgotPassword(String email) async {}
}
