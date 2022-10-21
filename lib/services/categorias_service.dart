import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasService {
  User? user = AuthService().getUser();

  final List<CategoriaDespesa> categoriasDespesas = [];
  final List<CategoriaFaturamento> categoriasFaturamentos = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  CategoriasService();

  getCategoriasDespesas() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('categoriasDespesas')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = CategoriaDespesa.fromJson(doc.data());
                categoriasDespesas.add(dado);
              }
            });
          }
        }
      });
      return categoriasDespesas;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setCategoriaDespesa(Map<String, dynamic> categoriaDespesa) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          dbProfiles
              .doc(doc.id)
              .collection('categoriasDespesas')
              .add(categoriaDespesa);
        }
      }
    });
  }

  getCategoriasFaturamentos() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('categoriasFaturamentos')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = CategoriaFaturamento.fromJson(doc.data());
                categoriasFaturamentos.add(dado);
              }
            });
          }
        }
      });
      return categoriasFaturamentos;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setCategoriaFaturamento(Map<String, dynamic> categoriaFaturamento) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          dbProfiles
              .doc(doc.id)
              .collection('categoriasFaturamentos')
              .add(categoriaFaturamento);
        }
      }
    });
  }
}
