import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:provider/provider.dart';

class DespesasWidget extends StatelessWidget {
  DespesasWidget({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> despesas = [];

  _getDespesas(BuildContext context) async {
    var db = FirebaseFirestore.instance;
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    await db.collection("profiles").get().then((event) async {
      for (var doc in event.docs) {
        if (doc.data()['email'] == authService.usuario?.email) {
          await db
              .collection('profiles')
              .doc(doc.id)
              .collection('despesas')
              .get()
              .then((value) {
            for (var doc in value.docs) {
              despesas.add(doc.data());
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getDespesas(context);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        const DateSelectWidget(),
        for (var despesa in despesas)
          ListTile(
            title: Text(despesa['titulo']),
            subtitle: Text('R\$ ${despesa['valor']}'),
            // leading: const Icon(Icons.battery_full),
            // trailing: const Icon(Icons.star),
          ),
      ],
    );
  }
}
