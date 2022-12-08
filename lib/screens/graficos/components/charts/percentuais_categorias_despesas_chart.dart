import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/screens/categorias/stores/stores.dart';
import 'package:projeto_controle_financeiro/screens/graficos/stores/stores.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class PercentuaisCategoriasDespesasChart extends StatelessWidget {
  PercentuaisCategoriasDespesasChart({Key? key}) : super(key: key);

  final PercentuaisCategoriasDespesasStore chartsPercentuaisStore =
      PercentuaisCategoriasDespesasStore();

  final ColorPick colorPick = ColorPick();

  final CategoriasStore categoriasStore = CategoriasStore('categoriasDespesas');

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<PercentuaisCategoriasDespesasStore, Exception,
        List<PieChartSectionData>>(
      store: chartsPercentuaisStore,
      onLoading: (context) => const CardLoadingWidget(
        info: 'Carregando o percentual',
      ),
      onError: (context, error) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.error_outline,
              size: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Verifique se há movimentações cadastradas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                color: projectTheme.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      onState:
          (context, List<PieChartSectionData> percentuaisCategoriasDespesas) {
        return AspectRatio(
          aspectRatio: 1.5,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 5,
                    centerSpaceRadius: 60,
                    sections: percentuaisCategoriasDespesas,
                  ),
                ),
              ),
              ScopedBuilder<CategoriasStore, Exception, List<Categoria>>(
                store: categoriasStore,
                onLoading: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
                onError: (context, error) => Text('$error'),
                onState: (context, List<Categoria> categoriasDespesas) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var categoriaDespesa in categoriasDespesas)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 2.0,
                                  bottom: 16.0,
                                ),
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: colorPick.getColor(categoriasDespesas
                                        .indexOf(categoriaDespesa)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 79,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 2.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text(
                                    categoriaDespesa.titulo,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
