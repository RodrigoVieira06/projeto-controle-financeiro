import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class DespesasStore extends NotifierStore<Exception, List<Despesa>> {
  final MovimentacoesService despesasService = MovimentacoesService();

  DespesasStore({DateTime? selectedDate}) : super([]) {
    getDespesas();
  }

  getDespesas({DateTime? selectedDate}) async {
    setLoading(true);
    try {
      List<Despesa> despesas = await despesasService.getDespesas();
      List<Despesa> despesasFiltered = _despesasFilter(selectedDate, despesas);
      update(despesasFiltered);
    } catch (error) {
      setError(Exception(error));
    }
    setLoading(false);
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
