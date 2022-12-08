import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class PercentuaisCategoriasFaturamentosStore
    extends NotifierStore<Exception, List<PieChartSectionData>> {
  final CategoriasService categoriasService = CategoriasService();
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final ColorPick colorPick = ColorPick();

  PercentuaisCategoriasFaturamentosStore() : super([]) {
    getSections();
  }

  getSections() async {
    setLoading(true);
    try {
      List<PieChartSectionData> sectionData = [];
      num valorTotal = 0;
      num valorTotalFaturamento = 0;
      double percentual;

      List<Faturamento> faturamentos =
          await movimentacoesService.getFaturamentos();
      List<Categoria> categorias =
          await categoriasService.getCategorias('categoriasFaturamentos');

      for (var faturamento in faturamentos) {
        valorTotal += faturamento.valor;
      }

      if (faturamentos.isEmpty || valorTotal == 0) {
        setError(Exception('Não há dados de movimentações cadastrados'));
        return;
      }

      for (var categoria in categorias) {
        for (var faturamento in faturamentos) {
          if (faturamento.categoria == categoria.titulo) {
            valorTotalFaturamento += faturamento.valor;
          }
        }

        percentual = (valorTotalFaturamento * 100) / valorTotal;
        valorTotalFaturamento = 0;

        sectionData.add(
          PieChartSectionData(
            color: colorPick.getColor(categorias.indexOf(categoria)),
            value: percentual,
            title: '${percentual.toStringAsFixed(1)}%',
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
      update(sectionData);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }
}
