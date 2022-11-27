import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class ResumomensalStore extends NotifierStore<Exception, Resumomensal> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final DateTime dataAtual = DateTime.now();

  ResumomensalStore()
      : super(Resumomensal(
          saldoMes: -1,
          balancoMes: -1,
          totalDespesas: -1,
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
        saldoMes: _getSaldoMes(despesasFiltered, faturamentosFiltered),
        balancoMes: _getBalancoMes(despesasFiltered, faturamentosFiltered),
        totalDespesas: _getDespesasMes(despesasFiltered),
        totalFaturamentos: _getFaturamentosMes(faturamentosFiltered),
      );

      update(resumomensal);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }

  num _getSaldoMes(List<Despesa> despesas, List<Faturamento> faturamentos) {
    num valorTotal = 0;
    return valorTotal;
  }

  num _getBalancoMes(List<Despesa> despesas, List<Faturamento> faturamentos) {
    num valorTotal = 0;
    return valorTotal;
  }

  num _getDespesasMes(List<Despesa> despesas) {
    num valorTotal = 0;
    return valorTotal;
  }

  num _getFaturamentosMes(List<Faturamento> faturamentos) {
    num valorTotal = 0;
    return valorTotal;
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
