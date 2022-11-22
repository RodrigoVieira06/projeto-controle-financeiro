import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:uuid/uuid.dart';

class MovimentacoesService {
  User? user = AuthService().getUser();
  CategoriasService categoriasService = CategoriasService();

  var dbProfiles = FirebaseFirestore.instance.collection('profiles');
  var uuid = const Uuid();

  MovimentacoesService();

  getDespesas() async {
    try {
      late List<Despesa> despesas = [];

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
            break;
          }
        }
      });
      despesas.sort((a, b) => b.data.compareTo(a.data));
      return despesas;
    } catch (error) {
      Exception(error);
    }
  }

  getDespesa(String despesaId) async {
    try {
      late Despesa despesa;

      await dbProfiles.get().then((response) async {
        for (var doc in response.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('despesas')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                if (doc.id == despesaId) {
                  despesa = Despesa.fromJson(doc.data());
                }
              }
            });
            break;
          }
        }
      });
      return despesa;
    } catch (error) {
      Exception(error);
    }
  }

  getFaturamentos() async {
    try {
      late List<Faturamento> faturamentos = [];

      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('faturamentos')
                .get()
                .then((faturamentosResponse) {
              for (var doc in faturamentosResponse.docs) {
                var dado = Faturamento.fromJson(doc.data());
                faturamentos.add(dado);
              }
            });
            break;
          }
        }
      });
      faturamentos.sort((a, b) => b.data.compareTo(a.data));
      return faturamentos;
    } catch (error) {
      Exception(error);
    }
  }

  getFaturamento(String faturamentoId) async {
    try {
      late Faturamento faturamento;

      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('faturamentos')
                .get()
                .then((faturamentosResponse) {
              for (var doc in faturamentosResponse.docs) {
                if (doc.id == faturamentoId) {
                  faturamento = Faturamento.fromJson(doc.data());
                  break;
                }
              }
            });
            break;
          }
        }
      });
      return faturamento;
    } catch (error) {
      Exception(error);
    }
  }

  setMovimentacao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      final String id = uuid.v4();
      entity['id'] = id;
      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // registrando o documento da coleção referente
            // ao entity solicitado (despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(id)
                .set(entity);
            break;
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }

  updateMovimentacao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      await dbProfiles.get().then((response) async {
        for (var doc in response.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // alterando o documento da coleção referente
            // ao entity solicitado (despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(entity['id'])
                .update(entity);
            break;
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }

  deleteMovimentacao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      await dbProfiles.get().then((response) async {
        for (var doc in response.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // alterando o documento da coleção referente
            // ao entity solicitado (despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(entity['id'])
                .delete();
            break;
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }
}
