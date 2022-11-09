import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:uuid/uuid.dart';

class CategoriasService {
  User? user = AuthService().getUser();

  var dbProfiles = FirebaseFirestore.instance.collection('profiles');
  var uuid = const Uuid();

  CategoriasService();

  getCategorias(String entityName) async {
    try {
      final List<Categoria> categorias = [];

      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = Categoria.fromJson(doc.data());
                categorias.add(dado);
              }
            });
          }
        }
      });
      categorias.sort((a, b) => b.data.compareTo(a.data));
      return categorias;
    } catch (error) {
      throw Exception(error);
    }
  }

  getCategoria(String uid, String entityName) async {
    try {
      late Categoria categoria;
      await dbProfiles.get().then((response) async {
        for (var doc in response.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .get()
                .then((value) {
              for (var doc in value.docs) {
                if (doc.id == uid) {
                  categoria = Categoria.fromJson(doc.data());
                }
              }
            });
            break;
          }
        }
      });
      return categoria;
    } catch (error) {
      throw Exception(error);
    }
  }

  setCategoria(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      final String uid = uuid.v4();
      entity['uid'] = uid;

      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // registrando o documento da coleção referente
            // ao entity solicitado (Categorias de despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(uid)
                .set(entity);
          }
        }
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  updateCategoria(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // alterando o documento da coleção referente
            // ao entity solicitado (despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(entity['uid'])
                .update(entity);
            break;
          }
        }
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  deleteCategoria(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      await dbProfiles.get().then((response) async {
        for (var doc in response.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // alterando o documento da coleção referente
            // ao entity solicitado (despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(entity['uid'])
                .delete();
            break;
          }
        }
      });
    } catch (error) {
      throw Exception(error);
    }
  }
}
