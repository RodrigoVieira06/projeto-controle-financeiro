import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/despesa.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class SaldoController extends NotifierStore<Exception, num> {
  final DespesasService despesasService = DespesasService();

  SaldoController() : super(-1) {
    getSaldo();
  }

  getSaldo() async {
    try {
      setLoading(true);
      num saldoAtual = 0;
      List<Despesa> despesas = await despesasService.getDespesas();
      for (var despesa in despesas) {
        saldoAtual += despesa.valor;
      }
      update(saldoAtual);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
