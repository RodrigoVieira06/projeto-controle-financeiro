import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/controllers/controllers.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

// ignore: must_be_immutable
class FaturamentosFormWidget extends StatelessWidget {
  FaturamentosFormWidget({Key? key}) : super(key: key);

  final FaturamentosController faturamentosController =
      FaturamentosController();

  final formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController categoriaFaturamento = TextEditingController();
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o valor.';
                    }
                    if (num.tryParse(value) == null) {
                      return '"$value" não é um número válido.';
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
                  controller: categoriaFaturamento,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Categoria de faturamento',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o categoria de faturamento.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: observacoes,
                  keyboardType: TextInputType.text,
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
                      Map<String, dynamic> faturamento = {
                        "titulo": titulo.text,
                        "valor": num.parse(valor.text),
                        "data": data.text,
                        "categoriaFaturamento": categoriaFaturamento.text,
                        "observacoes": observacoes.text,
                      };

                      faturamentosController.setFaturamento(faturamento);
                      Modular.to.popAndPushNamed('/movimentacoes/');
                      const SnackBar(
                        content: Text('Faturamento cadastrado com sucesso.'),
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
