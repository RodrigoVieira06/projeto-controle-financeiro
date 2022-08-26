import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _setUser() async {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  User? getUser() {
    return usuario;
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await _setUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Por favor, cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('Email inválido.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _setUser();
  }

  registrar(
    String email,
    String senha,
    String nome,
    String? foto,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await usuario?.updateDisplayName(nome);
      if (foto != null) {
        await usuario?.updatePhotoURL(foto);
      }
      _setUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já foi utilizado.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('Email inválido.');
      }
    }
  }
}
