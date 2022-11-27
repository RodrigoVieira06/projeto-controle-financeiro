import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/components/forms/faturamentos/faturamentos_form_controller.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/stores/stores.dart';

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
        FaturamentosFormStore(id: faturamentoId);

    return SingleChildScrollView(
      child: AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.attach_money,
                color: Colors.blue[400],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                'Cadastrar faturamento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Lato',
                ),
              ),
            ),
          ],
        ),
        content: ScopedBuilder<FaturamentosFormStore, Exception,
            Map<String, dynamic>>(
          store: faturamentosFormStore,
          onLoading: (context) => const CardLoadingWidget(
            info: 'Carregando informações.',
          ),
          onError: (context, error) => Text('$error'),
          onState: (context, Map<String, dynamic> dadosForm) {
            FaturamentosFormController faturamentosFormController =
                FaturamentosFormController(dadosForm);

            return Form(
              key: faturamentosFormController.formKey,
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: faturamentosFormController.titulo,
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
                        controller: faturamentosFormController.valor,
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
                      child: DateTimePicker(
                        controller: faturamentosFormController.data,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Data *',
                        ),
                        type: DateTimePickerType.date,
                        icon: const Icon(Icons.event),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        dateMask: 'dd/MM/yyyy',
                        validator: (value) {
                          if (value == null) {
                            return 'Informe a data';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: faturamentosFormController.categoriaValue,
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
                          faturamentosFormController.categoriaValue = value!;
                        },
                        items: faturamentosFormController.categoria
                            .map<DropdownMenuItem<String>>((String value) {
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
                        controller: faturamentosFormController.observacoes,
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
                              if (faturamentosFormController
                                  .formKey.currentState!
                                  .validate()) {
                                String valorTratado = faturamentosFormController
                                    .valor.text
                                    .replaceAll('R\$ ', '');
                                valorTratado = valorTratado.replaceAll(',', '');
                                Map<String, dynamic> faturamento = {
                                  "titulo":
                                      faturamentosFormController.titulo.text,
                                  "valor": num.parse(valorTratado),
                                  "data": DateFormat('y-M-d').parse(
                                      faturamentosFormController.data.text),
                                  "categoria":
                                      faturamentosFormController.categoriaValue,
                                  "observacoes": faturamentosFormController
                                      .observacoes.text,
                                };

                                if (faturamentoId != null) {
                                  faturamento['id'] = faturamentoId;
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
                                  content: Text(
                                      'Faturamento cadastrado com sucesso.'),
                                );
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
                    if (faturamentoId != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // inicio - definição de objeto a ser excluído
                            Map<String, dynamic> faturamento = {
                              'id': faturamentoId,
                              "titulo": faturamentosFormController.titulo.text,
                              "categoria":
                                  faturamentosFormController.categoriaValue,
                            };
                            // fim - definição de objeto a ser excluído

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteBoxWidget(
                                  funcaoExclusao:
                                      faturamentosFormStore.deleteFaturamento,
                                  entity: faturamento,
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
