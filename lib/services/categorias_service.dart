import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:uuid/uuid.dart';

class CategoriasService {
  User? user = AuthService().getUser();

  final List<CategoriaDespesa> categoriasDespesas = [];
  final List<CategoriaFaturamento> categoriasFaturamentos = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');
  var uuid = const Uuid();

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

  setCategoriaDespesa(
    String entity,
    Map<String, dynamic> categoria,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      final String uid = uuid.v4();
      categoria['uid'] = uid;
      categoria['bloqueado'] = false;
      categoria['valorTotal'] = 0;
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // obtendo a coleção referente ao entity solicitado (despesas ou faturamentos)
            var collection = dbProfiles.doc(doc.id).collection(entity);
            await collection.get().then((value) {
              collection.doc(uid).set(categoria);
            });
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }
}
