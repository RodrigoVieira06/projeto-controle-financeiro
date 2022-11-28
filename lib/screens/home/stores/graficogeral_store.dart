import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class GraficogeralStore
    extends NotifierStore<Exception, Map<String, List<FlSpot>>> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final DateTime dataAtual = DateTime.now();

  GraficogeralStore() : super({}) {
    getSpots();
  }

  getSpots() async {
    setLoading(true);
    try {
      List<FlSpot> despesasSpots = [];
      List<FlSpot> faturamentosSpots = [];
      List<FlSpot> balancoSpots = [];
      List<FlSpot> saldoSpots = [];
      Map<String, List<FlSpot>> spots;

      List<Despesa> despesas = await movimentacoesService.getDespesas();
      List<Faturamento> faturamentos =
          await movimentacoesService.getFaturamentos();

      for (var i = 1; i <= 12; i++) {
        double x = i.toDouble();

        double despesaY = _calcularDespesas(despesas, i);
        double faturamentoY = _calcularFaturamentos(faturamentos, i);
        double balancoY = _calcularBalanco(despesas, faturamentos, i);
        double saldoY = _calcularSaldo(despesas, faturamentos, i);

        despesasSpots.add(FlSpot(x, despesaY));
        faturamentosSpots.add(FlSpot(x, faturamentoY));
        balancoSpots.add(FlSpot(x, balancoY));
        saldoSpots.add(FlSpot(x, saldoY));
      }

      spots = {
        'despesas': despesasSpots,
        'faturamentos': faturamentosSpots,
        'balanco': balancoSpots,
        'saldo': saldoSpots,
      };
      update(spots);
    } catch (erro) {
      setError(Exception(erro));
    }
    setLoading(false);
  }

  double _calcularDespesas(List<Despesa> despesas, int i) {
    double despesaY = 0;

    for (var despesa in despesas) {
      DateTime despesaDate = DateTime.fromMicrosecondsSinceEpoch(
          despesa.data.microsecondsSinceEpoch);

      if (despesaDate.month == i && despesaDate.year == dataAtual.year) {
        despesaY += despesa.valor;
      }
    }

    return despesaY;
  }

  double _calcularFaturamentos(List<Faturamento> faturamentos, int i) {
    double faturamentoY = 0;

    for (var faturamento in faturamentos) {
      DateTime faturamentoDate = DateTime.fromMicrosecondsSinceEpoch(
          faturamento.data.microsecondsSinceEpoch);

      if (faturamentoDate.month == i &&
          faturamentoDate.year == dataAtual.year) {
        faturamentoY += faturamento.valor;
      }
    }

    return faturamentoY;
  }

  double _calcularBalanco(
    List<Despesa> despesas,
    List<Faturamento> faturamentos,
    int i,
  ) {
    double balanco = 0;
    double despesaMes = 0;
    double faturamentoMes = 0;

    for (var faturamento in faturamentos) {
      DateTime faturamentoDate = DateTime.fromMicrosecondsSinceEpoch(
          faturamento.data.microsecondsSinceEpoch);

      if (faturamentoDate.month == i &&
          faturamentoDate.year == dataAtual.year) {
        faturamentoMes += faturamento.valor;
      }
    }

    for (var despesa in despesas) {
      DateTime despesaDate = DateTime.fromMicrosecondsSinceEpoch(
          despesa.data.microsecondsSinceEpoch);

      if (despesaDate.month == i && despesaDate.year == dataAtual.year) {
        despesaMes += despesa.valor;
      }
    }

    balanco = faturamentoMes - despesaMes;

    return balanco;
  }

  double _calcularSaldo(
    List<Despesa> despesas,
    List<Faturamento> faturamentos,
    int i,
  ) {
    double saldo = 0;
    double despesaAteMes = 0;
    double faturamentoAteMes = 0;

    for (var faturamento in faturamentos) {
      DateTime faturamentoDate = DateTime.fromMicrosecondsSinceEpoch(
          faturamento.data.microsecondsSinceEpoch);

      if (faturamentoDate.month <= i &&
          faturamentoDate.year == dataAtual.year) {
        faturamentoAteMes += faturamento.valor;
      }
    }

    for (var despesa in despesas) {
      DateTime despesaDate = DateTime.fromMicrosecondsSinceEpoch(
          despesa.data.microsecondsSinceEpoch);

      if (despesaDate.month <= i && despesaDate.year == dataAtual.year) {
        despesaAteMes += despesa.valor;
      }
    }

    saldo = faturamentoAteMes - despesaAteMes;

    return saldo;
  }
}
