import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/services.dart';

class DrawerController {
  final AuthService _auth = AuthService();

  DrawerController();

  getProfile() async {
    var db = FirebaseFirestore.instance;
    var dbProfiles = db.collection('profiles');

    await dbProfiles.get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['uid'] == _auth.usuario?.uid) {
          return (await dbProfiles.doc(doc.id).get()) as Map<String, dynamic>?;
        }
      }
    });
  }
}
