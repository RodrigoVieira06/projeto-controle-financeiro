import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class FaturamentosController
    extends NotifierStore<Exception, List<Faturamento>> {
  final FaturamentosService faturamentosService = FaturamentosService();

  FaturamentosController() : super([]) {
    getFaturamentos();
  }

  getFaturamentos() async {
    try {
      setLoading(true);
      List<Faturamento> faturamentos =
          await faturamentosService.getFaturamentos();
      update(faturamentos);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  setFaturamento(Map<String, dynamic> faturamento) async {
    await faturamentosService.setFaturamento(faturamento);
    getFaturamentos();
  }
}
