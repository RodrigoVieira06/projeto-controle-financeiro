import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class AuthController {
  final AuthService authService = AuthService();

  AuthController();

  login(BuildContext context, String email, String senha) async {
    try {
      await authService.login(email, senha);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  register(
    BuildContext context,
    String email,
    String senha,
    String nome,
    String sobrenome,
    String? foto,
  ) async {
    try {
      await authService.register(email, senha, nome, sobrenome, foto);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  logout() async {
    await authService.logout();
  }
}
