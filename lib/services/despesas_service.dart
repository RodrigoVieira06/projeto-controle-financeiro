import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_controle_financeiro/models/despesa.dart';

import 'services.dart';

class DespesasService {
  AuthService authService = AuthService();
  final List<DespesasModel> despesas = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  DespesasService();

  getDespesas() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == authService.usuario?.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('despesas')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = DespesasModel.fromJson(doc.data());
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
        if (doc.data()['uid'] == authService.usuario?.uid) {
          dbProfiles.doc(doc.id).collection('despesas').add(despesa);
        }
      }
    });
  }
}
