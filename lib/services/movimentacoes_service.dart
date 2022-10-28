import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:uuid/uuid.dart';

class MovimentacoesService {
  User? user = AuthService().getUser();

  late List<Despesa> despesas = [];
  late List<Faturamento> faturamentos = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');
  var uuid = const Uuid();

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
      despesas.sort((a, b) => b.data.compareTo(a.data));
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
      faturamentos.sort((a, b) => b.data.compareTo(a.data));
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
    try {
      // atribuindo um identificador único ao cadastro
      final String uid = uuid.v4();
      movimento['uid'] = uid;
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // obtendo a coleção referente ao entity solicitado (despesas ou faturamentos)
            var collection = dbProfiles.doc(doc.id).collection(entity);
            await collection.get().then((value) {
              collection.doc(uid).set(movimento);
              final String tipoCategoria;
              final String categoria;
              if (entity == 'despesas') {
                categoria = 'categoriaDespesa';
                tipoCategoria = 'categoriasDespesas';
              } else {
                categoria = 'categoriaFaturamento';
                tipoCategoria = 'categoriasFaturamentos';
              }
              _updateCategoria(
                movimento[categoria],
                movimento['valor'],
                tipoCategoria,
              );
            });
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }

  _updateCategoria(String categoria, num valor, String tipoCategoria) async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            var collection = dbProfiles.doc(doc.id).collection(tipoCategoria);
            await collection.get().then((value) {
              for (var doc in value.docs) {
                if (doc.data()['titulo'] == categoria) {
                  var document = collection.doc(doc.id);
                  final num novoValor = valor + doc.data()['valorTotal'];
                  document.update({'valorTotal': novoValor});
                  break;
                }
              }
            });
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }
}
