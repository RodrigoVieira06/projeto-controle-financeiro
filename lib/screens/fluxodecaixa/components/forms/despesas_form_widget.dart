import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DespesasFormWidget extends StatelessWidget {
  DespesasFormWidget({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  _setDespesa(
    BuildContext context, {
    required Map<String, dynamic> despesa,
  }) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    var db = FirebaseFirestore.instance;

    await db.collection("profiles").get().then((event) {
      for (var doc in event.docs) {
        if (doc.data()['email'] == authService.usuario?.email) {
          db
              .collection('profiles')
              .doc(doc.id)
              .collection('despesas')
              .add(despesa);
        }
      }
    });
  }

  TextEditingController titulo = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController tipoDespesa = TextEditingController();
  TextEditingController formaPagamento = TextEditingController();
  TextEditingController observacoes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text(
          'Cadastrar despesa',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Lato',
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titulo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Título *',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o título.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: valor,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o valor.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: data,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a data.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tipoDespesa,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tipo de despesa',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o tipo de despesa.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: formaPagamento,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Forma de pagamento',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a forma de pagamento.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: observacoes,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observações',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0, top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Map<String, dynamic> despesa = {
                        "titulo": titulo.text,
                        "valor": valor.text,
                        "data": data.text,
                        "tipoDespesa": tipoDespesa.text,
                        "formaPagamento": formaPagamento.text,
                        "observacoes": observacoes.text,
                      };

                      _setDespesa(context, despesa: despesa);
                      Navigator.of(context).pop();
                      const SnackBar(
                        content: Text('Despesa cadastrada com sucesso.'),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: projectTheme.primaryColor,
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[400],
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
