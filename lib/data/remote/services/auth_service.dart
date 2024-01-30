import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:perebas_fc_app/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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

    final AuthResponseModel auth =
        AuthResponseModel.fromJson(json.decode(response.body));

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

    return true;
  }

  Future register(PlayerModel player) async {}
  Future forgotPassword(String email) async {}
}
