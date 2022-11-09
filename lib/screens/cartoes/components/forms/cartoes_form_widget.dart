import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/components/forms/cartoes_form_controller.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/masks.dart';

// ignore: must_be_immutable
class CartoesFormWidget extends StatelessWidget {
  final String entityName;
  final String? cartaoId;
  const CartoesFormWidget({
    Key? key,
    required this.entityName,
    this.cartaoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartoesFormStore cartoesFormStore = CartoesFormStore(
      entityName: entityName,
      uid: cartaoId,
    );

    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.credit_card,
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                'Cadastrar cartão',
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
        content:
            ScopedBuilder<CartoesFormStore, Exception, Map<String, dynamic>>(
          store: cartoesFormStore,
          onLoading: (context) => const CardLoadingWidget(
            info: 'Carregando informações.',
          ),
          onError: (context, error) => Text('$error'),
          onState: (context, Map<String, dynamic> dadosForm) {
            final CartoesFormController cartoesFormController =
                CartoesFormController(
              entityName,
              dadosForm,
            );

            return Form(
              key: cartoesFormController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cartoesFormController.titulo,
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
                  if (entityName == 'cartoesCredito')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cartoesFormController.diaVencimento,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(22),
                          Masks().diaVencimento,
                        ],
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Dia de vencimento*',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o dia de vencimento do cartão.';
                          }
                          var valueNumber = int.parse(value);
                          if (valueNumber > 28) {
                            return 'Dia inválido.';
                          }
                          return null;
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cartoesFormController.descricao,
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
                            if (cartoesFormController.formKey.currentState!
                                .validate()) {
                              Map<String, dynamic> cartao;
                              if (entityName == 'cartoesCredito') {
                                cartao = {
                                  'titulo': cartoesFormController.titulo.text,
                                  'diaVencimento': num.parse(
                                      cartoesFormController.diaVencimento.text),
                                  'data': Timestamp.now(),
                                  'bloqueado': false,
                                  "descricao":
                                      cartoesFormController.descricao.text,
                                };
                              } else {
                                cartao = {
                                  'titulo': cartoesFormController.titulo.text,
                                  'data': Timestamp.now(),
                                  'bloqueado': false,
                                  "descricao":
                                      cartoesFormController.descricao.text,
                                };
                              }

                              if (cartaoId != null) {
                                cartao['uid'] = cartaoId!;
                                await cartoesFormStore.updateCartao(
                                  entity: cartao,
                                  entityName: entityName,
                                );
                              } else {
                                await cartoesFormStore.setCartao(
                                  entity: cartao,
                                  entityName: entityName,
                                );
                              }
                              Modular.to.popAndPushNamed('/cartoes/');
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
                  if (cartaoId != null && !cartoesFormController.bloqueado)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // inicio - definição de objeto a ser excluído
                          Map<String, dynamic> cartao = {
                            'uid': cartaoId,
                            "titulo": cartoesFormController.titulo.text,
                          };
                          // fim - definição de objeto a ser excluído

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteBoxWidget(
                                funcaoExclusao: cartoesFormStore.deleteCartao,
                                entity: cartao,
                                path: '/cartoes/',
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
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
