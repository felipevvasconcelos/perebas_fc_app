import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:perebas_fc_app/presentation/pages/home/home.dart';
import 'package:perebas_fc_app/presentation/pages/signin/login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    authenticate().then((existsToken) => {
          existsToken
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
              : Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<bool> authenticate() async {
    const storage = FlutterSecureStorage();

    String? token = await storage.read(key: 'token');
    String? tokenExpiration = await storage.read(key: 'token_expiration');

    if (token == null || token == '') return false;
    if (tokenExpiration == null || tokenExpiration == '') return false;

    Map<String, dynamic> tokenProps = JwtDecoder.decode(token);
    String? idUser = tokenProps['id'];
    DateTime expiration = DateFormat('dd/MM/yyyy HH:mm').parse(tokenExpiration);

    if (idUser == null || idUser == '0') return false;
    if (expiration.isAfter(DateTime.now())) return false;

    return true;
  }
}
