import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/page/movimentacoes_controller.dart';
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
        content:
            ScopedBuilder<DespesasFormStore, Exception, Map<String, dynamic>>(
          store: despesasFormStore,
          onLoading: (context) => const CardLoadingWidget(
            info: 'Carregando dados do formulário.',
          ),
          onError: (context, error) => Text('$error'),
          onState: (context, Map<String, dynamic> dadosForm) {
            final MovimentacoesController movimentacoesController =
                MovimentacoesController();

            final formKey = GlobalKey<FormState>();

            TextEditingController titulo = TextEditingController();
            TextEditingController valor = TextEditingController();
            TextEditingController data = TextEditingController();
            TextEditingController observacoes = TextEditingController();

            String? formaPagamentoValue;
            String? categoriasDespesasValue;
            String? cartoesCreditoValue;
            String? cartoesDebitoValue;

            bool isCredit = false;
            bool isDebit = false;

            List<String>? categoriasDespesas = dadosForm['categoriasDespesas'];
            List<String>? cartoesCredito = dadosForm['cartoesCredito'];
            List<String>? cartoesDebito = dadosForm['cartoesDebito'];
            Despesa? despesa = dadosForm['despesa'];

            List<String> formasPagamento =
                movimentacoesController.getFormasPagamento();

            if (despesa != null) {
              titulo = TextEditingController(text: despesa.titulo);
              valor = TextEditingController(text: despesa.valor.toString());
              data = TextEditingController(
                  text: DateFormat('dd/MM/yyyy')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                despesa.data.millisecondsSinceEpoch,
              )));
              categoriasDespesasValue = despesa.categoria;
              formaPagamentoValue = despesa.formaPagamento;
              observacoes = TextEditingController(text: despesa.observacoes);
              if (despesa.formaPagamento == 'Crédito') {
                cartoesCreditoValue = despesa.cartao;
              } else if (despesa.formaPagamento == 'Débito') {
                cartoesDebitoValue = despesa.cartao;
              }
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titulo,
                      // initialValue: despesa?.titulo ?? '',
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
                      controller: valor,
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
                      controller: data,
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
                      value: categoriasDespesasValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Categoria de despesa',
                      ),
                      onChanged: (String? value) {
                        categoriasDespesasValue = value!;
                      },
                      items: categoriasDespesas
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
                      value: formaPagamentoValue,
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
                        formaPagamentoValue = value!;
                        if (value == 'Crédito') {
                          isCredit = true;
                          isDebit = false;
                        } else if (value == 'Débito') {
                          isDebit = true;
                          isCredit = false;
                        } else {
                          isCredit = false;
                          isDebit = false;
                        }
                      },
                      items: formasPagamento
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
                  if (isCredit)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: cartoesCreditoValue,
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
                          cartoesCreditoValue = value!;
                        },
                        items: cartoesCredito
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null && isCredit) {
                            return 'Informe o cartão.';
                          }
                          return null;
                        },
                      ),
                    ),
                  if (isDebit)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: cartoesDebitoValue,
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
                          cartoesDebitoValue = value!;
                        },
                        items: cartoesDebito
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null && isDebit) {
                            return 'Informe o cartão.';
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
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0, top: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          String valorTratado =
                              valor.text.replaceAll('R\$ ', '');
                          valorTratado = valorTratado.replaceAll(',', '');
                          String? cartao;
                          if (isCredit) {
                            cartao = cartoesCreditoValue;
                          } else if (isDebit) {
                            cartao = cartoesDebitoValue;
                          }
                          Map<String, dynamic> despesa = {
                            "titulo": titulo.text,
                            "valor": num.parse(valorTratado),
                            "data": DateFormat('d/M/y').parse(data.text),
                            "categoria": categoriasDespesasValue,
                            "formaPagamento": formaPagamentoValue,
                            "cartao": cartao,
                            "observacoes": observacoes.text,
                          };

                          if (despesaId != null) {
                            despesa['uid'] = despesaId;
                            await movimentacoesController.updateMovimento(
                              entity: 'despesas',
                              movimento: despesa,
                            );
                          } else {
                            await movimentacoesController.setMovimento(
                              entity: 'despesas',
                              movimento: despesa,
                            );
                          }
                          Modular.to.popAndPushNamed('/movimentacoes/');
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
            );
          },
        ),
      ),
    );
  }
}
