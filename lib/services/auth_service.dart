import 'package:cloud_firestore/cloud_firestore.dart';
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
    _getUser();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(
    String email,
    String senha,
    String nome,
    String sobrenome,
    String? foto,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await _auth.currentUser!.updateDisplayName(nome);
      usuario = _auth.currentUser;
      if (foto != null) {
        await usuario?.updatePhotoURL(foto);
      }
      _setProfile(nome: nome, sobrenome: sobrenome, email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw AuthException('A senha é muito fraca.');
        case 'email-already-in-use':
          throw AuthException('Este email já foi utilizado.');
        case 'invalid-email':
          throw AuthException('Email inválido.');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw AuthException('Email não encontrado. Por favor, cadastre-se.');
        case 'wrong-password':
          throw AuthException('Senha incorreta.');
        case 'invalid-email':
          throw AuthException('Email inválido.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
  }

  _setProfile({
    required String nome,
    required String sobrenome,
    required String email,
    DateTime? nascimento,
  }) {
    var db = FirebaseFirestore.instance;

    final profile = <String, dynamic>{
      "nome": nome,
      "sobrenome": sobrenome,
      "nascimento": nascimento,
      "email": email,
    };

    db.collection("profiles").add(profile);
  }
}