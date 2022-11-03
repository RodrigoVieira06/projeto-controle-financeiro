import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class DespesasFormStore extends NotifierStore<Exception, Map<String, dynamic>> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final CategoriasService categoriasService = CategoriasService();
  final CartoesService cartoesService = CartoesService();

  DespesasFormStore({String? uid}) : super({}) {
    getDados(despesaId: uid);
  }

  getDados({String? despesaId}) async {
    try {
      setLoading(true);

      List<Categoria> categoriasDespesas =
          await categoriasService.getCategoriasDespesas();
      Despesa? despesa;
      if (despesaId != null) {
        despesa = await movimentacoesService.getDespesa(despesaId);
      }

      List<String> categoriasDespesasValues = [];

      for (var categoriaDespesa in categoriasDespesas) {
        categoriasDespesasValues.add(categoriaDespesa.titulo);
      }

      Map<String, dynamic> dadosForm = {
        'categoriasDespesas': categoriasDespesasValues,
        'despesa': despesa
      };

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  setDespesa({
    required Map<String, dynamic> despesa,
  }) async {
    setLoading(true);
    await movimentacoesService.setMovimentacao('despesas', despesa);
    setLoading(false);
  }

  updateDespesa({
    required Map<String, dynamic> despesa,
  }) async {
    setLoading(true);
    await movimentacoesService.updateMovimentacao('despesas', despesa);
    setLoading(false);
  }

  deleteDespesa(
    Map<String, dynamic> despesa,
  ) async {
    setLoading(true);
    await movimentacoesService.deleteMovimentacao('despesas', despesa);
    setLoading(false);
  }
}
