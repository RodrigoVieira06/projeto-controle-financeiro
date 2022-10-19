import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class DespesasService {
  User? user = AuthService().getUser();

  final List<Despesa> despesas = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  DespesasService();

  getDespesas() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('despesas')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = Despesa.fromJson(doc.data());
                despesas.add(dado);
              }
            });
          }
        }
      });
      return despesas;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setDespesa(Map<String, dynamic> despesa) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          dbProfiles.doc(doc.id).collection('despesas').add(despesa);
        }
      }
    });
  }
}
