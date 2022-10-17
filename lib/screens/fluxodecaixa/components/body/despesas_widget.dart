import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/fluxodecaixa/controllers/controllers.dart';
import 'package:provider/provider.dart';

class DespesasWidget extends StatefulWidget {
  const DespesasWidget({Key? key}) : super(key: key);

  @override
  State<DespesasWidget> createState() => _DespesasWidgetState();
}

class _DespesasWidgetState extends State<DespesasWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // definindo margens por porcentagem
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: DateSelectWidget(),
          ),
          Consumer<DespesasController>(
              builder: (context, despesasContorller, child) {
            if (despesasContorller.loading.value) {
              return const LoadingWidget();
            } else if (despesasContorller.despesas.isEmpty) {
              return const ListaVaziaWidget();
            } else {
              return Column(
                children: [
                  for (final despesa in despesasContorller.despesas)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height * 0.1,
                            width: width * 0.98,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.money_off,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            despesa['titulo'],
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
                                        'R\$ ${despesa['valor']}',
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
                                        despesa['data'],
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
