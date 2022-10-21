import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasDespesasController
    extends NotifierStore<Exception, List<CategoriaDespesa>> {
  final CategoriasService categoriasService = CategoriasService();

  CategoriasDespesasController() : super([]) {
    getCategoriasDespesas();
  }

  getCategoriasDespesas() async {
    try {
      setLoading(true);
      List<CategoriaDespesa> categoriasDespesas =
          await categoriasService.getCategoriasDespesas();
      update(categoriasDespesas);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  setCategoriaDespesa(Map<String, dynamic> categoriaDespesa) async {
    await categoriasService.setCategoriaDespesa(categoriaDespesa);
    getCategoriasDespesas();
  }
}
