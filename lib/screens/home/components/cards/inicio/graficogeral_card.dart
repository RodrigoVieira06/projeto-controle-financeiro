import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/stores/stores.dart';

class GraficogeralCard extends StatelessWidget {
  GraficogeralCard({Key? key}) : super(key: key);
  final GraficogeralStore graficogeralStore = GraficogeralStore();
  final GraficogeralWidget graficogeralWidget = GraficogeralWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            height: 390,
            child: ScopedBuilder<GraficogeralStore, Exception,
                Map<String, List<FlSpot>>>(
              store: graficogeralStore,
              onLoading: (context) =>
                  const CardLoadingWidget(info: 'Carregando visão geral.'),
              onError: (context, error) => Text('$error'),
              onState: (context, Map<String, List<FlSpot>> graficogeral) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Gráfico geral - ${DateTime.now().year.toString()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, top: 16.0),
                      child: graficogeralWidget.buildWidget(
                        context,
                        graficogeral,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Icon(
                                  Icons.square,
                                  color: Colors.red,
                                  size: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text(
                                  'Despesas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Icon(
                                  Icons.square,
                                  color: Colors.blue,
                                  size: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Text(
                                  'Faturamentos',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Icon(
                                  Icons.square,
                                  color: Colors.green,
                                  size: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Text(
                                  'Balanço',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Icon(
                                  Icons.square,
                                  color: Colors.deepPurple,
                                  size: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 1.0),
                                child: Text(
                                  'Saldo disponível',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ]),
      ]),
    );
  }
}
