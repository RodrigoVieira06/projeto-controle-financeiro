import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/categorias/components/components.dart';
import 'package:projeto_controle_financeiro/screens/categorias/stores/stores.dart';
import 'package:projeto_controle_financeiro/stores/stores.dart';

class CategoriasFaturamentosWidget extends StatelessWidget {
  final String entityName;
  const CategoriasFaturamentosWidget({
    Key? key,
    required this.entityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // definindo a lista através de um store
    final CategoriasStore categoriasStore = CategoriasStore(entityName);

    // definindo margens por porcentagem
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ScopedBuilder<CategoriasStore, Exception, List<Categoria>>(
          store: categoriasStore,
          onLoading: (context) => const LoadingWidget(),
          onError: (context, error) => Text('$error'),
          onState: (context, List<Categoria> categorias) {
            if (categorias.isEmpty) {
              return const Center(
                child: ListaVaziaWidget(),
              );
            } else {
              return Column(
                children: [
                  for (final categoria in categorias)
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
                                  return CategoriasFormWidget(
                                    entityName: entityName,
                                    categoriaId: categoria.id,
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
                                              Icons.money_off,
                                              color: Colors.blue[400],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              categoria.titulo,
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
                                      ScopedBuilder<PercentualGastosStore,
                                          Exception, num>(
                                        store: PercentualGastosStore(
                                          categoria.titulo,
                                          'Faturamento',
                                        ),
                                        onLoading: (context) => const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                        onError: (context, error) =>
                                            Text('$error'),
                                        onState:
                                            (context, num percentualGastos) {
                                          final Color? percentualColor;

                                          if (percentualGastos > 0) {
                                            percentualColor = Colors.blue;
                                          } else {
                                            percentualColor = Colors.black;
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 120,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 1.0),
                                                    child: Text(
                                                      'Percentual de gastos por categorias:',
                                                      style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 1.0),
                                                  child: Text(
                                                    '${percentualGastos.toStringAsFixed(1)}%',
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 16,
                                                      color: percentualColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
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
