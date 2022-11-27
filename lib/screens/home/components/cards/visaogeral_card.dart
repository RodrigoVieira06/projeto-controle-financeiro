import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/stores/stores.dart';
import 'package:projeto_controle_financeiro/models/visaogeral.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class VisaogeralCard extends StatelessWidget {
  const VisaogeralCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VisaogeralStore visaogeralStore = VisaogeralStore();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            height: 250,
            child: ScopedBuilder<VisaogeralStore, Exception, Visaogeral>(
              store: visaogeralStore,
              onLoading: (context) =>
                  const CardLoadingWidget(info: 'Carregando visão geral.'),
              onError: (context, error) => Text('$error'),
              onState: (context, Visaogeral visaogeral) {
                final Color? colorSaldoAtual;
                final Color? colorMediaBalancoMensal;

                if (visaogeral.saldoAtual > 0) {
                  colorSaldoAtual = Colors.blue[400];
                } else if (visaogeral.saldoAtual < 0) {
                  colorSaldoAtual = Colors.red[400];
                } else {
                  colorSaldoAtual = Colors.black;
                }

                if (visaogeral.mediaBalancoMensal > 0) {
                  colorMediaBalancoMensal = Colors.blue[400];
                } else if (visaogeral.mediaBalancoMensal < 0) {
                  colorMediaBalancoMensal = Colors.red[400];
                } else {
                  colorMediaBalancoMensal = Colors.black;
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 8.0),
                        child: Text(
                          'Visão geral',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons.attach_money,
                                  color: projectTheme.iconTheme.color,
                                  size: projectTheme.iconTheme.size,
                                ),
                              ),
                              const Text(
                                'Saldo atual',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'R\$${visaogeral.saldoAtual.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              color: colorSaldoAtual,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons.money_off,
                                  color: projectTheme.iconTheme.color,
                                  size: projectTheme.iconTheme.size,
                                ),
                              ),
                              const Text(
                                'Média de despesas \nmensais',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'R\$${visaogeral.mediaDespesasMensais.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              color: Colors.red[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons.balance,
                                  color: projectTheme.iconTheme.color,
                                  size: projectTheme.iconTheme.size,
                                ),
                              ),
                              const Text(
                                'Média de balanço \nmensal',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'R\$${visaogeral.mediaBalancoMensal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              color: colorMediaBalancoMensal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
