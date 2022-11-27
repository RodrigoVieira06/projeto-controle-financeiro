import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/home/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class ResumodespesasCard {
  const ResumodespesasCard();

  Widget buildWidget(
      BuildContext context, ResumodespesasStore resumodespesasStore) {
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
                height: 365,
                child: ScopedBuilder<ResumodespesasStore, Exception,
                    Resumodespesas>(
                  store: resumodespesasStore,
                  onLoading: (context) => const CardLoadingWidget(
                      info: 'Carregando resumo de despesas.'),
                  onError: (context, error) => Text('$error'),
                  onState: (context, Resumodespesas resumodespesas) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 8.0),
                            child: Text(
                              'Resumo de despesas',
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
                                'R\$${resumodespesas.total.toStringAsFixed(2)}',
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
                            top: 24,
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Icon(
                                      Icons.credit_card,
                                      color: projectTheme.iconTheme.color,
                                      size: projectTheme.iconTheme.size,
                                    ),
                                  ),
                                  const Text(
                                    'Total em crédito',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumodespesas.totalCredito.toStringAsFixed(2)}',
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
                                      Icons.credit_card,
                                      color: projectTheme.iconTheme.color,
                                      size: projectTheme.iconTheme.size,
                                    ),
                                  ),
                                  const Text(
                                    'Total em débito',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumodespesas.totalDebito.toStringAsFixed(2)}',
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
                                      Icons.money,
                                      color: projectTheme.iconTheme.color,
                                      size: projectTheme.iconTheme.size,
                                    ),
                                  ),
                                  const Text(
                                    'Total em dinheiro',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumodespesas.totalDinheiro.toStringAsFixed(2)}',
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
                                      Icons.pix,
                                      color: projectTheme.iconTheme.color,
                                      size: projectTheme.iconTheme.size,
                                    ),
                                  ),
                                  const Text(
                                    'Total em pix',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'R\$${resumodespesas.totalPix.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                  color: Colors.red[400],
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
