import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/categorias/controllers/controllers.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

// ignore: must_be_immutable
class CategoriasDespesasFormWidget extends StatelessWidget {
  CategoriasDespesasFormWidget({Key? key}) : super(key: key);

  final categoriasDespesasController =
      Modular.get<CategoriasDespesasController>(
    defaultValue: CategoriasDespesasController(),
  );

  final formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text(
          'Cadastrar categoria de despesa',
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
                  controller: descricao,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
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
                        "observacoes": descricao.text,
                      };

                      categoriasDespesasController.setCategoriaDespesa(despesa);
                      Modular.to.popAndPushNamed('/categorias/');
                      const SnackBar(
                        content: Text(
                            'Categoria de despesa cadastrada com sucesso.'),
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
