import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/components/components.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/stores/stores.dart';

class DespesasWidget extends StatelessWidget {
  const DespesasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // definindo a lista através de um store
    final DespesasStore despesasStore = DespesasStore();

    // definindo margens por porcentagem
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: DateselectButtonsWidget(),
          ),
          ScopedBuilder<DespesasStore, Exception, List<Despesa>>(
              store: despesasStore,
              onLoading: (context) => const LoadingWidget(),
              onError: (context, error) => Text('$error'),
              onState: (context, List<Despesa> despesas) {
                if (despesas.isEmpty) {
                  return const ListaVaziaWidget();
                } else {
                  return Column(
                    children: [
                      for (final despesa in despesas)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DespesasFormWidget(
                                        despesaId: despesa.uid,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: height * 0.1,
                                  width: width * 0.95,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.money_off,
                                                  color: Colors.red[400],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  despesa.titulo,
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'R\$ ${despesa.valor.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                color: Colors.red[400],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                despesa.data
                                                    .millisecondsSinceEpoch,
                                              )),
                                              style: const TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
