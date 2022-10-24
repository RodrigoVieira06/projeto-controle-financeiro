import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/page/movimentacoes_controller.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

// ignore: must_be_immutable
class DespesasFormWidget extends StatefulWidget {
  const DespesasFormWidget({Key? key}) : super(key: key);

  @override
  State<DespesasFormWidget> createState() => _DespesasFormWidgetState();
}

class _DespesasFormWidgetState extends State<DespesasFormWidget> {
  final DespesasFormStore despesasFormStore = DespesasFormStore();
  final MovimentacoesController movimentacoesController =
      MovimentacoesController();

  final formKey = GlobalKey<FormState>();

  TextEditingController titulo = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController observacoes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> formasPagamento = movimentacoesController.getFormasPagamento();
    String formaPagamentoValue = formasPagamento.first;

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
        content: ScopedBuilder<DespesasFormStore, Exception,
            Map<String, List<String>?>>(
          store: despesasFormStore,
          onLoading: (context) => const CardLoadingWidget(
            info: 'Carregando dados do formulário.',
          ),
          onError: (context, error) => Text('$error'),
          onState: (context, Map<String, List<String>?> dadosForm) {
            List<String>? categoriasDespesas = dadosForm['categoriasDespesas'];
            // List<String>? cartoesCredito = dadosForm['cartoesCredito'];
            // List<String>? cartoesDebito = dadosForm['cartoesDebito'];

            String categoriasDespesasValue = categoriasDespesas!.first;

            // if (cartoesCredito!.isNotEmpty) {
            //   String cartoesCreditoValue = cartoesCredito.first;
            // }
            // if (cartoesDebito!.isNotEmpty) {
            //   String cartoesDebitoValue = cartoesDebito.first;
            // }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titulo,
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
                        if (value!.isEmpty) {
                          return 'Informe a data.';
                        }
                        if (value.length < 10) {
                          return 'Preencha a data completa';
                        }
                        return null;
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
                        // This is called when the user selects an item.
                        setState(() {
                          categoriasDespesasValue = value!;
                        });
                      },
                      items: categoriasDespesas
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                        // This is called when the user selects an item.
                        setState(() {
                          formaPagamentoValue = value!;
                        });
                      },
                      items: formasPagamento
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                          Map<String, dynamic> despesa = {
                            "titulo": titulo.text,
                            "valor": num.parse(valorTratado),
                            "data": DateFormat('d/M/y').parse(data.text),
                            "categoriaDespesa": categoriasDespesasValue,
                            "formaPagamento": formaPagamentoValue,
                            "observacoes": observacoes.text,
                          };
                          await movimentacoesController.setMovimento(
                            entity: 'despesas',
                            movimento: despesa,
                          );
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
