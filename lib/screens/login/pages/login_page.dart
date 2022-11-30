import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/login/components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: LoginWidget(),
    );
  }
}
