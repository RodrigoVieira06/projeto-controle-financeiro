import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/home/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class ResumomensalCard {
  const ResumomensalCard();

  Widget buildWidget(
      BuildContext context, ResumomensalStore resumomensalStore) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                height: 310,
                child:
                    ScopedBuilder<ResumomensalStore, Exception, Resumomensal>(
                  store: resumomensalStore,
                  onLoading: (context) => const CardLoadingWidget(
                      info: 'Carregando resumo mensal.'),
                  onError: (context, error) => Text('$error'),
                  onState: (context, Resumomensal resumomensal) {
                    final Color? corSaldoMes;
                    final Color? corBalanco;

                    if (resumomensal.saldoMes > 0) {
                      corSaldoMes = Colors.blue[400];
                    } else if (resumomensal.saldoMes < 0) {
                      corSaldoMes = Colors.red[400];
                    } else {
                      corSaldoMes = projectTheme.primaryColor;
                    }

                    if (resumomensal.balancoMes > 0) {
                      corBalanco = Colors.blue[400];
                    } else if (resumomensal.balancoMes < 0) {
                      corBalanco = Colors.red[400];
                    } else {
                      corBalanco = projectTheme.primaryColor;
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 8.0),
                            child: Text(
                              'Resumo mensal',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Icon(
                                      Icons.account_balance,
                                      color: projectTheme.iconTheme.color,
                                      size: projectTheme.iconTheme.size,
                                    ),
                                  ),
                                  const Text(
                                    'Saldo da conta ao \nfim do mês',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumomensal.saldoMes.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                  color: corSaldoMes,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24, left: 16, right: 16),
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
                                    'Balanço do mês',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumomensal.balancoMes.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                  color: corBalanco,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24, left: 16, right: 16),
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
                                    'Despesas do mês',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumomensal.totalDespesas.toStringAsFixed(2)}',
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
                          padding: const EdgeInsets.only(
                              top: 24, left: 16, right: 16),
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
                                    'Faturamentos do mês',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumomensal.totalFaturamentos.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                  color: Colors.blue[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
