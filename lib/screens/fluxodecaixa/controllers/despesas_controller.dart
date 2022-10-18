import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class DespesasController extends NotifierStore<Exception, List<DespesasModel>> {
  final DespesasService despesasService = DespesasService();

  DespesasController() : super([]) {
    getDespesas();
  }

  getDespesas() async {
    try {
      setLoading(true);
      List<DespesasModel> despesas = await despesasService.getDespesas();
      update(despesas);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  setDespesa(Map<String, dynamic> despesa) async {
    await despesasService.setDespesa(despesa);
    getDespesas();
  }
}
