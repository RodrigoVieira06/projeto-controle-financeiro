import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class FaturamentosService {
  User? user = AuthService().getUser();

  final List<Faturamento> faturamentos = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  FaturamentosService();

  getFaturamentos() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('faturamentos')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = Faturamento.fromJson(doc.data());
                faturamentos.add(dado);
              }
            });
          }
        }
      });
      return faturamentos;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setFaturamento(Map<String, dynamic> faturamento) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          dbProfiles.doc(doc.id).collection('faturamentos').add(faturamento);
        }
      }
    });
  }
}
