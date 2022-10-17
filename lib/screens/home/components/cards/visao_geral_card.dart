import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/home/controllers/controllers.dart';
import 'package:projeto_controle_financeiro/screens/home/module/home_module.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

import '../../controllers/controllers.dart';

class VisaoGeralCard extends StatelessWidget {
  const VisaoGeralCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InicioController inicioController = Modular.get<InicioController>(
      defaultValue: InicioController(),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Card(
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
              child: inicioController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
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
                                'R\$${inicioController.saldoAtual.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
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
                                    'Média de despesas mensais',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'R\$0,00',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
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
                                    'Média de balanço mensal',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'R\$0,00',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
