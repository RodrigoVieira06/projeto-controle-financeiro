import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class FaturamentosFormStore
    extends NotifierStore<Exception, Map<String, dynamic>> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final CategoriasService categoriasService = CategoriasService();
  final CartoesService cartoesService = CartoesService();

  FaturamentosFormStore({String? uid}) : super({}) {
    getDados(faturamentoId: uid);
  }

  getDados({String? faturamentoId}) async {
    try {
      setLoading(true);

      List<CategoriaFaturamento> categoriasFaturamentos =
          await categoriasService.getCategoriasFaturamentos();
      Faturamento? faturamento;
      if (faturamentoId != null) {
        faturamento = await movimentacoesService.getFaturamento(faturamentoId);
      }

      List<String> categoriasFaturamentosValues = [];

      for (var categoriaFaturamento in categoriasFaturamentos) {
        categoriasFaturamentosValues.add(categoriaFaturamento.titulo);
      }

      Map<String, dynamic> dadosForm = {
        'categoriasFaturamentos': categoriasFaturamentosValues,
        'faturamento': faturamento,
      };

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
