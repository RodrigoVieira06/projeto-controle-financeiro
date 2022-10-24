import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CartoesService {
  User? user = AuthService().getUser();

  final List<CartaoCredito> cartoesCredito = [];
  final List<CartaoDebito> cartoesDebito = [];
  var dbProfiles = FirebaseFirestore.instance.collection('profiles');

  CartoesService();

  getCartoesCredito() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('cartoesCredito')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = CartaoCredito.fromJson(doc.data());
                cartoesCredito.add(dado);
              }
            });
          }
        }
      });
      return cartoesCredito;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setCartaoCredito(Map<String, dynamic> cartaoCredito) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          dbProfiles
              .doc(doc.id)
              .collection('cartoesCredito')
              .add(cartaoCredito);
        }
      }
    });
  }

  getCartoesDebito() async {
    try {
      await dbProfiles.get().then((event) async {
        for (var doc in event.docs) {
          if (doc.data()['uid'] == user!.uid) {
            await dbProfiles
                .doc(doc.id)
                .collection('cartoesDebito')
                .get()
                .then((value) {
              for (var doc in value.docs) {
                var dado = CartaoDebito.fromJson(doc.data());
                cartoesDebito.add(dado);
              }
            });
          }
        }
      });
      return cartoesDebito;
    } catch (error) {
      Exception(error);
    }
    return null;
  }

  setCartaoDebito(Map<String, dynamic> cartaoDebito) async {
    await dbProfiles.get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == user!.uid) {
          dbProfiles.doc(doc.id).collection('cartoesDebito').add(cartaoDebito);
        }
      }
    });
  }
}
