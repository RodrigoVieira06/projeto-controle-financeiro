import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dbProfiles = FirebaseFirestore.instance.collection('profiles');
  bool isLoading = false;
  User? usuario;
  Map<String, dynamic>? profile;

  AuthService() {
    _authCheck();
    _getUser();
    _getProfile();
  }

  registrar(
    String email,
    String senha,
    String nome,
    String sobrenome,
    String? foto,
  ) async {
    try {
      _setLoading(true);
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await _auth.currentUser!.updateDisplayName(nome);
      usuario = _auth.currentUser;
      if (foto != null) {
        await usuario?.updatePhotoURL(foto);
      }
      _setProfile(nome: nome, sobrenome: sobrenome, email: email);
      _setLoading(false);
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

  logar(String email, String senha) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
      await _getProfile();
      _setLoading(false);
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
    _setLoading(true);
    await _auth.signOut();
    profile = {};
    _setLoading(false);
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      notifyListeners();
    });
  }

  _setLoading(bool valor) {
    isLoading = valor;
    notifyListeners();
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  _getProfile() async {
    await dbProfiles.get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == usuario?.uid) {
          await dbProfiles.doc(doc.id).get().then((response) {
            profile = response.data();
          });
          notifyListeners();
        }
      }
    });
  }

  _setProfile({
    required String nome,
    required String sobrenome,
    required String email,
  }) async {
    var db = FirebaseFirestore.instance;

    final newProfile = <String, dynamic>{
      "uid": usuario!.uid,
      "nome": nome,
      "sobrenome": sobrenome,
      "email": email,
    };

    await db.collection("profiles").add(newProfile);
    _getProfile();
  }
}
