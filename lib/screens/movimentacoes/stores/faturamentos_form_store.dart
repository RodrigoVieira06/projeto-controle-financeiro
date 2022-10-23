import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class FaturamentosFormStore
    extends NotifierStore<Exception, Map<String, List<String>?>> {
  final CategoriasService categoriasService = CategoriasService();
  final CartoesService cartoesService = CartoesService();

  FaturamentosFormStore() : super({}) {
    getDados();
  }

  getDados() async {
    try {
      setLoading(true);

      List<CategoriaFaturamento> categoriasFaturamentos =
          await categoriasService.getCategoriasFaturamentos();

      List<String> categoriasFaturamentosValues = [];

      for (var categoriaFaturamento in categoriasFaturamentos) {
        categoriasFaturamentosValues.add(categoriaFaturamento.titulo);
      }

      Map<String, List<String>?> dadosForm = {
        'categoriasFaturamentos': categoriasFaturamentosValues,
      };

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
