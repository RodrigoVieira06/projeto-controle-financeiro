import 'package:cloud_firestore/cloud_firestore.dart';

import 'services.dart';

class DespesasService {
  AuthService authService = AuthService();
  final List<Map<String, dynamic>> despesas = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  DespesasService();

  getDespesas() async {
    await dbProfiles.get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == authService.usuario?.uid) {
          await dbProfiles
              .doc(doc.id)
              .collection('despesas')
              .get()
              .then((value) {
            for (var doc in value.docs) {
              despesas.add(doc.data());
            }
          });
        }
      }
    });
    return despesas;
  }

  setDespesa(Map<String, dynamic> despesa) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == authService.usuario?.uid) {
          dbProfiles.doc(doc.id).collection('despesas').add(despesa);
        }
      }
    });
  }
}
