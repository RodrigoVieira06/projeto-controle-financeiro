import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FaturamentosFormWidget extends StatelessWidget {
  FaturamentosFormWidget({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

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
          'Cadastrar faturamento',
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observações',
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cadastrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
