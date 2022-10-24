import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class MovimentacoesService {
  User? user = AuthService().getUser();

  late List<Despesa> despesas = [];
  late List<Faturamento> faturamentos = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  MovimentacoesService();

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
      despesas = [...despesas].reversed.toList();
      return despesas;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

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
      faturamentos = [...faturamentos].reversed.toList();
      return faturamentos;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setMovimento(
    String entity,
    Map<String, dynamic> movimento,
  ) async {
    int total = 0;

    await dbProfiles.get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          var collection = dbProfiles.doc(doc.id).collection(entity);

          await collection.get().then((value) {
            total = value.docs.length;
            collection.doc('$entity$total').set(movimento);
          });
        }
      }
    });
  }
}
