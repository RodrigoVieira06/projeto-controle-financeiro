import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class PercentuaisCategoriasDespesasStore
    extends NotifierStore<Exception, List<PieChartSectionData>> {
  final CategoriasService categoriasService = CategoriasService();
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final ColorPick colorPick = ColorPick();

  PercentuaisCategoriasDespesasStore() : super([]) {
    getSections();
  }

  getSections() async {
    setLoading(true);
    try {
      List<PieChartSectionData> sectionData = [];
      num valorTotal = 0;
      num valorTotalDespesa = 0;
      double percentual;

      List<Despesa> despesas = await movimentacoesService.getDespesas();
      List<Categoria> categorias =
          await categoriasService.getCategorias('categoriasDespesas');

      for (var despesa in despesas) {
        valorTotal += despesa.valor;
      }

      if (despesas.isEmpty || valorTotal == 0) {
        setError(Exception('Não há dados de movimentações cadastrados'));
        return;
      }

      for (var categoria in categorias) {
        for (var despesa in despesas) {
          if (despesa.categoria == categoria.titulo) {
            valorTotalDespesa += despesa.valor;
          }
        }

        percentual = (valorTotalDespesa * 100) / valorTotal;
        valorTotalDespesa = 0;

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
