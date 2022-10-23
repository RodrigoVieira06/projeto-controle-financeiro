import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class DespesasStore extends NotifierStore<Exception, List<Despesa>> {
  final MovimentacoesService despesasService = MovimentacoesService();

  DespesasStore() : super([]) {
    getDespesas();
  }

  getDespesas() async {
    try {
      setLoading(true);
      List<Despesa> despesas = await despesasService.getDespesas();
      update(despesas);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
