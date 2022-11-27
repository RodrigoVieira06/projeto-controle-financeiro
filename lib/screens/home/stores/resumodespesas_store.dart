import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class ResumodespesasStore extends NotifierStore<Exception, Resumodespesas> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final DateTime dataAtual = DateTime.now();

  ResumodespesasStore()
      : super(Resumodespesas(
          total: -1,
          totalCredito: -1,
          totalDebito: -1,
          totalDinheiro: -1,
          totalPix: -1,
        )) {
    getDados();
  }

  getDados({DateTime? selectedDate}) async {
    setLoading(true);
    try {
      final List<Despesa> despesas = await movimentacoesService.getDespesas();
      final List<Despesa> despesasFiltered = _despesasFilter(
        selectedDate,
        despesas,
      );

      final Resumodespesas resumodespesas = Resumodespesas(
        total: _getDespesasMes(despesasFiltered),
        totalDebito: _getTotalDebito(despesasFiltered),
        totalCredito: _getTotalCredito(despesasFiltered),
        totalDinheiro: _getTotalDinheiro(despesasFiltered),
        totalPix: _getTotalPix(despesasFiltered),
      );

      update(resumodespesas);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
  }

  num _getDespesasMes(List<Despesa> despesas) {
    num despesaTotal = 0;

    for (var despesa in despesas) {
      despesaTotal += despesa.valor;
    }

    return despesaTotal;
  }

  num _getTotalDebito(List<Despesa> despesas) {
    num valorTotal = 0;

    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Débito") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }

  num _getTotalCredito(List<Despesa> despesas) {
    num valorTotal = 0;
    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Crédito") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }

  num _getTotalDinheiro(List<Despesa> despesas) {
    num valorTotal = 0;
    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Dinheiro") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }

  num _getTotalPix(List<Despesa> despesas) {
    num valorTotal = 0;
    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Pix") {
        valorTotal += despesa.valor;
      }
    }
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
}
