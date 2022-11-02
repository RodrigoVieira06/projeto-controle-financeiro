import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

// ignore: must_be_immutable
class FaturamentosFormWidget extends StatelessWidget {
  final String? faturamentoId;
  const FaturamentosFormWidget({
    Key? key,
    this.faturamentoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FaturamentosFormStore faturamentosFormStore =
        FaturamentosFormStore(uid: faturamentoId);

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
        content: ScopedBuilder<FaturamentosFormStore, Exception,
            Map<String, dynamic>>(
          store: faturamentosFormStore,
          onLoading: (context) => const CardLoadingWidget(
            info: 'Carregando dados do formulário.',
          ),
          onError: (context, error) => Text('$error'),
          onState: (context, Map<String, dynamic> dadosForm) {
            final formKey = GlobalKey<FormState>();

            TextEditingController titulo = TextEditingController();
            TextEditingController valor = TextEditingController();
            TextEditingController data = TextEditingController();
            TextEditingController observacoes = TextEditingController();

            String? categoriasFaturamentosValue;

            List<String>? categoriasFaturamentos =
                dadosForm['categoriasFaturamentos'];
            Faturamento? faturamento = dadosForm['faturamento'];

            if (faturamento != null) {
              titulo = TextEditingController(text: faturamento.titulo);
              valor = TextEditingController(text: faturamento.valor.toString());
              data = TextEditingController(
                  text: DateFormat('dd/MM/yyyy')
                      .format(DateTime.fromMillisecondsSinceEpoch(
                faturamento.data.millisecondsSinceEpoch,
              )));
              observacoes =
                  TextEditingController(text: faturamento.observacoes);
              categoriasFaturamentosValue = faturamento.categoria;
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
                      inputFormatters: [Masks().dateMask],
                      controller: data,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Data *',
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
                      value: categoriasFaturamentosValue,
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
                        categoriasFaturamentosValue = value!;
                      },
                      items: categoriasFaturamentos
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          String valorTratado =
                              valor.text.replaceAll('R\$ ', '');
                          valorTratado = valorTratado.replaceAll(',', '');
                          Map<String, dynamic> faturamento = {
                            "titulo": titulo.text,
                            "valor": num.parse(valorTratado),
                            "data": DateFormat('d/M/y').parse(data.text),
                            "categoria": categoriasFaturamentosValue,
                            "observacoes": observacoes.text,
                          };

                          if (faturamentoId != null) {
                            faturamento['uid'] = faturamentoId;
                            await faturamentosFormStore.updateFaturamento(
                              faturamento: faturamento,
                            );
                          } else {
                            await faturamentosFormStore.setFaturamento(
                              faturamento: faturamento,
                            );
                          }
                          Modular.to.popAndPushNamed('/movimentacoes/');
                          const SnackBar(
                            content:
                                Text('Faturamento cadastrado com sucesso.'),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: projectTheme.primaryColor,
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text(
                        'Salvar',
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
                  ),
                  if (faturamentoId != null)
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
                          'Excluir',
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