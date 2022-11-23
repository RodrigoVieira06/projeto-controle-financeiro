import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/categorias/components/form/categorias_form_controller.dart';
import 'package:projeto_controle_financeiro/screens/categorias/stores/stores.dart';
import 'package:projeto_controle_financeiro/stores/stores.dart';

// ignore: must_be_immutable
class CategoriasFormWidget extends StatelessWidget {
  final String entityName;
  final String? categoriaId;
  const CategoriasFormWidget({
    Key? key,
    required this.entityName,
    this.categoriaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoriasFormStore categoriasFormStore = CategoriasFormStore(
      entityName: entityName,
      id: categoriaId,
    );

    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.bookmarks_rounded,
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                'Cadastrar categoria',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Lato',
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        content: ScopedBuilder<CategoriasFormStore, Exception,
                Map<String, dynamic>>(
            store: categoriasFormStore,
            onLoading: (context) => const CardLoadingWidget(
                  info: 'Carregando informações.',
                ),
            onError: (context, error) => Text('$error'),
            onState: (context, Map<String, dynamic> dadosForm) {
              final CategoriasFormController categoriasFormController =
                  CategoriasFormController(dadosForm);

              return Form(
                key: categoriasFormController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: categoriasFormController.titulo,
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
                        controller: categoriasFormController.descricao,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descrição',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (categoriasFormController.formKey.currentState!
                                  .validate()) {
                                // inicio - definição de objeto a ser cadastrado
                                Map<String, Object> categoria = {
                                  'titulo':
                                      categoriasFormController.titulo.text,
                                  'descricao':
                                      categoriasFormController.descricao.text,
                                  'data': Timestamp.now(),
                                };
                                // fim - definição de objeto a ser cadastrado

                                if (categoriaId != null) {
                                  categoria['id'] = categoriaId!;
                                  await categoriasFormStore.updateCategoria(
                                    entity: categoria,
                                    entityName: entityName,
                                  );
                                } else {
                                  await categoriasFormStore.setCategoria(
                                    entity: categoria,
                                    entityName: entityName,
                                  );
                                }
                                Modular.to.popAndPushNamed('/categorias/');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 0, 27, 67),
                              minimumSize: const Size(110, 40),
                              maximumSize: const Size(110, 40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 2.0),
                                  child: Icon(
                                    Icons.check,
                                    size: 18,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    'Salvar',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black26,
                              minimumSize: const Size(110, 40),
                              maximumSize: const Size(110, 40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 2.0),
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    size: 18,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (categoriaId != null)
                      ScopedBuilder<BotaoexcluirStore, Exception, num>(
                          store: BotaoexcluirStore(categoriaId!, entityName),
                          onLoading: (context) => const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                          onError: (context, error) => Text('$error'),
                          onState: (context, num bloqueado) {
                            if (bloqueado == 2) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // inicio - definição de objeto a ser excluído
                                    Map<String, dynamic> categoria = {
                                      'id': categoriaId,
                                      "titulo":
                                          categoriasFormController.titulo.text,
                                    };
                                    // fim - definição de objeto a ser excluído

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DeleteBoxWidget(
                                          funcaoExclusao: categoriasFormStore
                                              .deleteCategoria,
                                          entity: categoria,
                                          path: '/categorias/',
                                          entityName: entityName,
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red[400],
                                    minimumSize: const Size(110, 40),
                                    maximumSize: const Size(110, 40),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.0),
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.0),
                                        child: Text(
                                          'Excluir',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
