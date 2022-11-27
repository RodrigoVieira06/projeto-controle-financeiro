import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class FaturamentosStore extends NotifierStore<Exception, List<Faturamento>> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  FaturamentosStore() : super([]) {
    getFaturamentos();
  }

  getFaturamentos({DateTime? selectedDate}) async {
    try {
      setLoading(true);
      List<Faturamento> faturamentos =
          await movimentacoesService.getFaturamentos();
      List<Faturamento> faturamentosFiltered =
          _faturamentosFilter(selectedDate, faturamentos);
      update(faturamentosFiltered);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
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
