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

  logout(BuildContext context) async {
    try {
      await authService.logout();
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  alterarSenha(BuildContext context, String senha) async {
    try {
      await authService.alterarSenha(senha);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha alterada com sucesso')));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  delete(BuildContext context) async {
    try {
      await authService.delete();
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
