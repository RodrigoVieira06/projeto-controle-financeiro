import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'services.dart';

class FaturamentosService {
  AuthService authService = AuthService();
  final List<Map<String, dynamic>> faturamentos = [];

  FaturamentosService();

  getFaturamentos() async {
    var db = FirebaseFirestore.instance;

    await db.collection("profiles").get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['email'] == authService.usuario?.email) {
          await db
              .collection('profiles')
              .doc(doc.id)
              .collection('faturamentos')
              .get()
              .then((value) {
            for (var doc in value.docs) {
              faturamentos.add(doc.data());
            }
          });
        }
      }
    });
    return faturamentos;
  }

  setDespesa(
    BuildContext context, {
    required Map<String, dynamic> despesa,
  }) async {
    var db = FirebaseFirestore.instance;

    await db.collection("profiles").get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['email'] == authService.usuario?.email) {
          db
              .collection('profiles')
              .doc(doc.id)
              .collection('despesas')
              .add(despesa);
        }
      }
    });
  }
}
