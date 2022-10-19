import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/services/auth_service.dart';

class AuthController extends NotifierStore<Exception, FirebaseAuth> {
  final AuthService authService = AuthService();

  AuthController() : super(FirebaseAuth.instance);

  login(BuildContext context, String email, String senha) async {
    try {
      setLoading(true);
      FirebaseAuth auth = await authService.login(email, senha);
      update(auth);
      setLoading(false);
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
      setLoading(true);
      FirebaseAuth auth =
          await authService.register(email, senha, nome, sobrenome, foto);
      update(auth);
      setLoading(false);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  logout() async {
    setLoading(true);
    await authService.logout();
    setLoading(false);
  }
}
