import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/components/components.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/stores/stores.dart';
import 'package:projeto_controle_financeiro/stores/stores.dart';

class CartoesCreditoWidget extends StatelessWidget {
  const CartoesCreditoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // definindo a lista através de um store
    final CartoesCreditoStore cartoesCreditoStore = CartoesCreditoStore();

    // definindo margens por porcentagem
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ScopedBuilder<CartoesCreditoStore, Exception, List<CartaoCredito>>(
          store: cartoesCreditoStore,
          onLoading: (context) => const LoadingWidget(),
          onError: (context, error) => Text('$error'),
          onState: (context, List<CartaoCredito> cartoesCredito) {
            if (cartoesCredito.isEmpty) {
              return const Center(
                child: ListaVaziaWidget(),
              );
            } else {
              return Column(
                children: [
                  for (final cartaoCredito in cartoesCredito)
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
                                  return CartoesFormWidget(
                                    entityName: 'cartoesCredito',
                                    cartaoId: cartaoCredito.id,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.credit_card,
                                              color: Colors.green[400],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              cartaoCredito.titulo,
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
                                      ScopedBuilder<MediamensalStore, Exception,
                                          num>(
                                        store: MediamensalStore(
                                          cartaoCredito.titulo,
                                          'Crédito',
                                        ),
                                        onLoading: (context) => const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        onError: (context, error) =>
                                            Text('$error'),
                                        onState: (context, num mediamensal) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Média mensal: R\$ ${mediamensal.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        },
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
    );
  }
}
