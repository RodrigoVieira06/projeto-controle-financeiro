import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:uuid/uuid.dart';

class CartoesService {
  User? user = AuthService().getUser();

  var dbProfiles = FirebaseFirestore.instance.collection('profiles');
  var uuid = const Uuid();

  CartoesService();

  getCartoes(String entityName) async {
    try {
      if (entityName == 'cartoesCredito') {
        List<CartaoCredito> cartoes = [];
        await dbProfiles.get().then((profiles) async {
          for (var doc in profiles.docs) {
            if (doc.data()['uid'] == user!.uid) {
              await dbProfiles
                  .doc(doc.id)
                  .collection(entityName)
                  .get()
                  .then((entities) {
                for (var doc in entities.docs) {
                  var dado = CartaoCredito.fromJson(doc.data());
                  cartoes.add(dado);
                }
              });
            }
          }
        });
        cartoes.sort((a, b) => b.data.compareTo(a.data));
        return cartoes;
      } else {
        List<CartaoDebito> cartoes = [];
        await dbProfiles.get().then((event) async {
          for (var doc in event.docs) {
            if (doc.data()['uid'] == user!.uid) {
              await dbProfiles
                  .doc(doc.id)
                  .collection(entityName)
                  .get()
                  .then((value) {
                for (var doc in value.docs) {
                  var dado = CartaoDebito.fromJson(doc.data());
                  cartoes.add(dado);
                }
              });
            }
          }
        });
        cartoes.sort((a, b) => b.data.compareTo(a.data));
        return cartoes;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  getCartao(String id, String entityName) async {
    try {
      if (entityName == 'cartoesCredito') {
        late CartaoCredito cartao;
        await dbProfiles.get().then((response) async {
          for (var doc in response.docs) {
            if (doc.data()['uid'] == user!.uid) {
              await dbProfiles
                  .doc(doc.id)
                  .collection(entityName)
                  .get()
                  .then((value) {
                for (var doc in value.docs) {
                  if (doc.id == id) {
                    cartao = CartaoCredito.fromJson(doc.data());
                  }
                }
              });
              break;
            }
          }
        });
        return cartao;
      } else {
        late CartaoDebito cartao;
        await dbProfiles.get().then((response) async {
          for (var doc in response.docs) {
            if (doc.data()['uid'] == user!.uid) {
              await dbProfiles
                  .doc(doc.id)
                  .collection(entityName)
                  .get()
                  .then((value) {
                for (var doc in value.docs) {
                  if (doc.id == id) {
                    cartao = CartaoDebito.fromJson(doc.data());
                  }
                }
              });
              break;
            }
          }
        });
        return cartao;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  setCartao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    // atribuindo um identificador único ao cadastro
    final String id = uuid.v4();
    entity['id'] = id;

    await dbProfiles.get().then((profileResponse) async {
      for (var doc in profileResponse.docs) {
        if (doc.data()['uid'] == user!.uid) {
          // registrando o documento da coleção referente
          // ao entity solicitado (Categorias de despesas ou faturamentos)
          await dbProfiles
              .doc(doc.id)
              .collection(entityName)
              .doc(id)
              .set(entity);
        }
      }
    });
  }

  updateCartao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      // atribuindo um identificador único ao cadastro
      await dbProfiles.get().then((profileResponse) async {
        for (var doc in profileResponse.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // alterando o documento da coleção referente
            // ao entity solicitado (crédito ou débito)
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
      throw Exception(error);
    }
  }

  deleteCartao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    try {
      await dbProfiles.get().then((response) async {
        for (var doc in response.docs) {
          if (doc.data()['uid'] == user!.uid) {
            // alterando o documento da coleção referente
            // ao entity solicitado (crédito ou débito)
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
      throw Exception(error);
    }
  }
}
