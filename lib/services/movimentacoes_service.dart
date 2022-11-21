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
      final String uid = uuid.v4();
      entity['uid'] = uid;
      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // registrando o documento da coleção referente
            // ao entity solicitado (despesas ou faturamentos)
            await dbProfiles
                .doc(doc.id)
                .collection(entityName)
                .doc(uid)
                .set(entity);
            await _updateValorTotalCategorias(entityName, entity['categoria']);
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
                .doc(entity['uid'])
                .update(entity);
            await _updateValorTotalCategorias(entityName, entity['categoria']);
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
                .doc(entity['uid'])
                .delete();
            await _updateValorTotalCategorias(entityName, entity['categoria']);
            break;
          }
        }
      });
    } catch (error) {
      Exception(error);
    }
  }

  _updateValorTotalCategorias(
    String entityName,
    String categoria,
  ) async {
    try {
      String tipoCategoria;
      // definindo tipo de categoria a ser alterada
      entityName == 'despesas'
          ? tipoCategoria = 'categoriasDespesas'
          : tipoCategoria = 'categoriasFaturamentos';

      // consultando tipos de categorias do profile do usuário
      await dbProfiles.get().then((profileResponse) async {
        for (var profileDoc in profileResponse.docs) {
          if (profileDoc.data()['uid'] == user!.uid) {
            var categoriaCollection =
                dbProfiles.doc(profileDoc.id).collection(tipoCategoria);
            // atualizando todas as categorias após adicionar o movimento
            await categoriaCollection.get().then((categoriasResponse) async {
              for (var categoriaDoc in categoriasResponse.docs) {
                // redefine valor total da categoria
                num valorTotal = 0;
                await dbProfiles
                    .doc(profileDoc.id)
                    .collection(entityName)
                    .get()
                    .then((entityResponse) {
                  // buscando os movimentos que utilizam a categoria desejada
                  for (var entityDoc in entityResponse.docs) {
                    // contabliza todos os valores encontrados
                    if (entityDoc.data()['categoria'] ==
                        categoriaDoc.data()['titulo']) {
                      valorTotal += entityDoc.data()['valor'];
                    }
                  }
                  // atualiza o valor total da categoria
                  categoriaCollection
                      .doc(categoriaDoc.id)
                      .update({'valorTotal': valorTotal});
                });
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
