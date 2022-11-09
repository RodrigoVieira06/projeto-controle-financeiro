import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dbProfiles = FirebaseFirestore.instance.collection('profiles');
  late User usuario;
  Profile profile = Profile();

  AuthService();

  register(
    String email,
    String senha,
    String nome,
    String sobrenome,
    String? foto,
  ) async {
    try {
      var nomeCompleto = '$nome $sobrenome';
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await _auth.currentUser!.updateDisplayName(nomeCompleto);
      await _setProfile(
        _auth.currentUser!.uid,
        _auth.currentUser!.displayName!,
        _auth.currentUser!.email!,
      );
      await _setDadosIniciais();
      if (foto != null) {
        await _auth.currentUser!.updatePhotoURL(foto);
      }
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
    profile = Profile();
  }

  User? getUser() {
    return _auth.currentUser;
  }

  getProfile() async {
    await dbProfiles.get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == _auth.currentUser!.uid) {
          await dbProfiles.doc(doc.id).get().then((response) {
            var dado = Profile.fromJson(response.data()!);
            profile = dado;
          });
        }
      }
    });
  }

  _setProfile(String uid, String nome, String email) async {
    profile = Profile(nome: nome, email: email, uid: uid);
    await dbProfiles.doc(uid).set({
      "nome": nome,
      "email": email,
      "uid": uid,
    });
  }

  _setDadosIniciais() async {
    ConfiguracoesIniciais configuracoesIniciais = ConfiguracoesIniciais();
    CategoriasService categoriasService = CategoriasService();

    for (Map<String, dynamic> categoriaDespesa
        in configuracoesIniciais.categoriasDespesas) {
      await categoriasService.setCategoria(
          'categoriasDespesas', categoriaDespesa);
    }

    for (Map<String, dynamic> categoriaFaturamento
        in configuracoesIniciais.categoriasFaturamentos) {
      await categoriasService.setCategoria(
          'categoriasFaturamentos', categoriaFaturamento);
    }
  }
}
