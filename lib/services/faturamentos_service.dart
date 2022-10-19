import 'package:projeto_controle_financeiro/models/models.dart';

class FaturamentosService {
  Profile auth = Profile();
  final List<Map<String, dynamic>> faturamentos = [];

  FaturamentosService();

  getFaturamentos() async {
    // var db = FirebaseFirestore.instance;

    // await db.collection("profiles").get().then((event) async {
    //   for (var doc in event.docs) {
    //     if (doc.data()['email'] == auth.usuario?.email) {
    //       await db
    //           .collection('profiles')
    //           .doc(doc.id)
    //           .collection('faturamentos')
    //           .get()
    //           .then((value) {
    //         for (var doc in value.docs) {
    //           faturamentos.add(doc.data());
    //         }
    //       });
    //     }
    //   }
    // });
    return faturamentos;
  }
}
