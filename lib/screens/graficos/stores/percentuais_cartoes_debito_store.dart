import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class PercentuaisCartoesDebitoStore
    extends NotifierStore<Exception, List<PieChartSectionData>> {
  final CartoesService cartoesService = CartoesService();
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final ColorPick colorPick = ColorPick();

  PercentuaisCartoesDebitoStore() : super([]) {
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
      List<CartaoDebito> cartoes =
          await cartoesService.getCartoes('cartoesDebito');

      for (var despesa in despesas) {
        if (despesa.formaPagamento == 'Débito') {
          valorTotal += despesa.valor;
        }
      }

      if (despesas.isEmpty || valorTotal == 0) {
        setError(Exception('Não há dados de movimentações cadastrados'));
        return;
      }

      for (var cartao in cartoes) {
        for (var despesa in despesas) {
          if (despesa.cartao == cartao.titulo) {
            valorTotalDespesa += despesa.valor;
          }
        }

        percentual = (valorTotalDespesa * 100) / valorTotal;
        valorTotalDespesa = 0;

        sectionData.add(
          PieChartSectionData(
            color: colorPick.getColor(cartoes.indexOf(cartao)),
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
