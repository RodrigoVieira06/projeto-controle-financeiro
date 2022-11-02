import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/categorias/stores/stores.dart';

class CategoriasFaturamentosWidget extends StatelessWidget {
  const CategoriasFaturamentosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // definindo a lista através de um store
    final CategoriasFaturamentosStore categoriasFaturamentosStore =
        CategoriasFaturamentosStore();

    // definindo margens por porcentagem
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ScopedBuilder<CategoriasFaturamentosStore, Exception,
              List<Categoria>>(
          store: categoriasFaturamentosStore,
          onLoading: (context) => const LoadingWidget(),
          onError: (context, error) => Text('$error'),
          onState: (context, List<Categoria> categoriasFaturamentos) {
            if (categoriasFaturamentos.isEmpty) {
              return const Center(
                child: ListaVaziaWidget(),
              );
            } else {
              return Column(
                children: [
                  for (final categoriasFaturamento in categoriasFaturamentos)
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
                                            Icons.attach_money,
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            categoriasFaturamento.titulo,
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
                                        'Média mensal: R\$ ${categoriasFaturamento.valorTotal.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 14,
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
    );
  }
}
