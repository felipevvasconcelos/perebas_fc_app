import 'package:intl/intl.dart';

class AuthResponseModel {
  final bool authenticated;
  final DateTime expiration;
  final String accessToken;
  final String refreshToken;

  AuthResponseModel({
    required this.authenticated,
    required this.expiration,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        authenticated: json['authenticated'],
        expiration: DateFormat('dd/MM/yyyy HH:mm').parse(json['expiration']),
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
}
