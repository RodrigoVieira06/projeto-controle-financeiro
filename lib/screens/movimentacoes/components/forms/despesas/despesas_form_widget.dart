import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/components/forms/despesas/despesas_form_controller.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class DespesasFormWidget extends StatelessWidget {
  final String? despesaId;
  const DespesasFormWidget({
    Key? key,
    this.despesaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DespesasFormStore despesasFormStore =
        DespesasFormStore(uid: despesaId);
    final TipoPagamentoStore tipoPagamentoStore = TipoPagamentoStore();

    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.money_off,
                color: Colors.red[400],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                'Cadastrar despesa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
        content:
            ScopedBuilder<DespesasFormStore, Exception, Map<String, dynamic>>(
          store: despesasFormStore,
          onLoading: (context) => const CardLoadingWidget(
            info: 'Carregando informações.',
          ),
          onError: (context, error) => Text('$error'),
          onState: (context, Map<String, dynamic> dadosForm) {
            final DespesasFormController despesasFormController =
                DespesasFormController(dadosForm);

            return Form(
              key: despesasFormController.formKey,
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: despesasFormController.titulo,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(22),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Título *',
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 16,
                        ),
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
                        controller: despesasFormController.valor,
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            symbol: 'R\$ ',
                          ),
                          LengthLimitingTextInputFormatter(15),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Valor *',
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe o valor.';
                          }
                          String number = value.replaceAll('R\$ ', '');
                          number = number.replaceAll(',', '');
                          if (num.tryParse(number) == null) {
                            return '"$value" não é um número válido.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: despesasFormController.data,
                        inputFormatters: [Masks().dateMask],
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Data *',
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Informe a data.';
                          }
                          final components = value.split("/");
                          if (components.length == 3) {
                            final int? day = int.tryParse(components[0]);
                            final int? month = int.tryParse(components[1]);
                            final int? year = int.tryParse(components[2]);
                            if (day == null ||
                                month == null ||
                                year == null ||
                                day < 1 ||
                                day > 31 ||
                                month < 1 ||
                                month > 12 ||
                                year < 1900) {
                              return "Data inválida";
                            } else {
                              return null;
                            }
                          }
                          return "Preencha a data corretamente";
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: despesasFormController.categoriaValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Categoria',
                        ),
                        onChanged: (String? value) {
                          despesasFormController.categoriaValue = value!;
                        },
                        items: despesasFormController.categoria
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Informe a categoria.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: despesasFormController.formaPagamentoValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Forma de pagamento',
                        ),
                        onChanged: (String? value) {
                          despesasFormController.formaPagamentoValue = value!;
                          if (value == 'Crédito') {
                            tipoPagamentoStore.setTipoPagamento(true, false);
                          } else if (value == 'Débito') {
                            tipoPagamentoStore.setTipoPagamento(false, true);
                          } else {
                            tipoPagamentoStore.setTipoPagamento(false, false);
                          }
                        },
                        items: despesasFormController.formasPagamento
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Informe a forma de pagamento.';
                          }
                          return null;
                        },
                      ),
                    ),
                    ScopedBuilder<TipoPagamentoStore, Exception,
                            Map<String, dynamic>>(
                        store: tipoPagamentoStore,
                        onLoading: (context) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                        onError: (context, error) => Text('$error'),
                        onState:
                            (context, Map<String, dynamic> tipoPagamentoStore) {
                          if (tipoPagamentoStore['isCredit']) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                value:
                                    despesasFormController.cartoesCreditoValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Cartão de crédito',
                                ),
                                onChanged: (String? value) {
                                  despesasFormController.cartoesCreditoValue =
                                      value!;
                                },
                                items: tipoPagamentoStore['cartoes']
                                    ?.map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null &&
                                      tipoPagamentoStore['isCredit']) {
                                    return 'Informe o cartão.';
                                  }
                                  return null;
                                },
                              ),
                            );
                          } else if (tipoPagamentoStore['isDebit']) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                value:
                                    despesasFormController.cartoesDebitoValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Cartão de débito',
                                ),
                                onChanged: (String? value) {
                                  despesasFormController.cartoesDebitoValue =
                                      value!;
                                },
                                items: tipoPagamentoStore['cartoes']
                                    ?.map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null &&
                                      tipoPagamentoStore['isDebit']) {
                                    return 'Informe o cartão.';
                                  }
                                  return null;
                                },
                              ),
                            );
                          }
                          return Container();
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: despesasFormController.observacoes,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Observações',
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (despesasFormController.formKey.currentState!
                                  .validate()) {
                                // inicio - tratamento da string de valor sem máscaras
                                String valorTratado = despesasFormController
                                    .valor.text
                                    .replaceAll('R\$ ', '');
                                valorTratado = valorTratado.replaceAll(',', '');
                                // fim - tratamento da string de valor sem máscaras

                                // inicio - definir tipo cartão de cartão
                                String? cartao;
                                despesasFormController.cartoesCreditoValue !=
                                        null
                                    ? cartao = despesasFormController
                                        .cartoesCreditoValue
                                    : cartao = despesasFormController
                                        .cartoesDebitoValue;
                                // fim - definir tipo cartão de cartão

                                // inicio - definição de objeto a ser cadastrado
                                Map<String, dynamic> despesa = {
                                  "titulo": despesasFormController.titulo.text,
                                  "valor": num.parse(valorTratado),
                                  "data": DateFormat('d/M/y')
                                      .parse(despesasFormController.data.text),
                                  "categoria":
                                      despesasFormController.categoriaValue,
                                  "formaPagamento": despesasFormController
                                      .formaPagamentoValue,
                                  "cartao": cartao,
                                  "observacoes":
                                      despesasFormController.observacoes.text,
                                };
                                // fim - definição de objeto a ser cadastrado

                                if (despesaId != null) {
                                  despesa['uid'] = despesaId;
                                  await despesasFormStore.updateDespesa(
                                    despesa: despesa,
                                  );
                                } else {
                                  await despesasFormStore.setDespesa(
                                    despesa: despesa,
                                  );
                                }
                                Modular.to.popAndPushNamed('/movimentacoes/');
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
                    if (despesaId != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // inicio - definir tipo cartão de cartão
                            String? cartao;
                            despesasFormController.cartoesCreditoValue != null
                                ? cartao =
                                    despesasFormController.cartoesCreditoValue
                                : cartao =
                                    despesasFormController.cartoesDebitoValue;
                            // fim - definir tipo cartão de cartão

                            // inicio - definição de objeto a ser excluído
                            Map<String, dynamic> despesa = {
                              'uid': despesaId,
                              "titulo": despesasFormController.titulo.text,
                              'categoria':
                                  despesasFormController.categoriaValue,
                              'cartao': cartao,
                            };
                            // fim - definição de objeto a ser excluído

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteBoxWidget(
                                  funcaoExclusao:
                                      despesasFormStore.deleteDespesa,
                                  entity: despesa,
                                  path: '/movimentacoes/',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
