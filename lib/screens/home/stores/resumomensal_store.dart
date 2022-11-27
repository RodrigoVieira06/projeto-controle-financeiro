import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class ResumomensalStore extends NotifierStore<Exception, Resumomensal> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  ResumomensalStore()
      : super(Resumomensal(
          saldoMes: -1,
          balancoMes: -1,
          totalFaturamentos: -1,
        )) {
    getDados();
  }

  getDados({DateTime? selectedDate}) async {
    setLoading(true);
    try {
      final List<Despesa> despesas = await movimentacoesService.getDespesas();
      final List<Faturamento> faturamentos =
          await movimentacoesService.getFaturamentos();
      final List<Despesa> despesasFiltered = _despesasFilter(
        selectedDate,
        despesas,
      );
      final List<Faturamento> faturamentosFiltered = _faturamentosFilter(
        selectedDate,
        faturamentos,
      );

      final Resumomensal resumomensal = Resumomensal(
        saldoMes: _getSaldoMes(despesas, faturamentos, selectedDate),
        balancoMes: _getBalancoMes(despesasFiltered, faturamentosFiltered),
        totalFaturamentos: _getFaturamentosMes(faturamentosFiltered),
      );

      update(resumomensal);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }

  num _getSaldoMes(
    List<Despesa> despesas,
    List<Faturamento> faturamentos,
    DateTime? selectedDate,
  ) {
    final DateTime date;
    num despesaTotal = 0;
    num faturamentoTotal = 0;
    num valorTotal = 0;

    (selectedDate != null) ? date = selectedDate : date = DateTime.now();

    for (var despesa in despesas) {
      DateTime despesaDate = DateTime.fromMicrosecondsSinceEpoch(
          despesa.data.microsecondsSinceEpoch);
      if (despesaDate.year < date.year ||
          (despesaDate.year == date.year && despesaDate.month <= date.month)) {
        despesaTotal += despesa.valor;
      }
    }
    for (var faturamento in faturamentos) {
      DateTime faturamentoDate = DateTime.fromMicrosecondsSinceEpoch(
          faturamento.data.microsecondsSinceEpoch);
      if (faturamentoDate.year < date.year ||
          (faturamentoDate.year == date.year &&
              faturamentoDate.month <= date.month)) {
        faturamentoTotal += faturamento.valor;
      }
    }

    valorTotal = faturamentoTotal - despesaTotal;

    return valorTotal;
  }

  num _getBalancoMes(List<Despesa> despesas, List<Faturamento> faturamentos) {
    num despesaTotal = 0;
    num faturamentoTotal = 0;
    num valorTotal = 0;

    for (var despesa in despesas) {
      despesaTotal += despesa.valor;
    }
    for (var faturamento in faturamentos) {
      faturamentoTotal += faturamento.valor;
    }

    valorTotal = faturamentoTotal - despesaTotal;

    return valorTotal;
  }

  num _getFaturamentosMes(List<Faturamento> faturamentos) {
    num faturamentoTotal = 0;

    for (var faturamento in faturamentos) {
      faturamentoTotal += faturamento.valor;
    }

    return faturamentoTotal;
  }

  List<Despesa> _despesasFilter(
      DateTime? selectedDate, List<Despesa> despesas) {
    final DateTime date;
    List<Despesa> despesaFiltered = [];

    selectedDate == null ? date = DateTime.now() : date = selectedDate;

    for (var despesa in despesas) {
      num despesaMonth = DateTime.fromMicrosecondsSinceEpoch(
              despesa.data.microsecondsSinceEpoch)
          .month;
      num despesaYear = DateTime.fromMicrosecondsSinceEpoch(
              despesa.data.microsecondsSinceEpoch)
          .year;

      if (despesaMonth == date.month && despesaYear == date.year) {
        despesaFiltered.add(despesa);
      }
    }
    return despesaFiltered;
  }

  List<Faturamento> _faturamentosFilter(
      DateTime? selectedDate, List<Faturamento> faturamentos) {
    final DateTime date;
    List<Faturamento> faturamentoFiltered = [];

    selectedDate == null ? date = DateTime.now() : date = selectedDate;

    for (var faturamento in faturamentos) {
      num faturamentoMonth = DateTime.fromMicrosecondsSinceEpoch(
              faturamento.data.microsecondsSinceEpoch)
          .month;
      num faturamentoYear = DateTime.fromMicrosecondsSinceEpoch(
              faturamento.data.microsecondsSinceEpoch)
          .year;

      if (faturamentoMonth == date.month && faturamentoYear == date.year) {
        faturamentoFiltered.add(faturamento);
      }
    }
    return faturamentoFiltered;
  }
}
