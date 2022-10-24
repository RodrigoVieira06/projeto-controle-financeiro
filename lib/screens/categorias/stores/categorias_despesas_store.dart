import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasDespesasStore
    extends NotifierStore<Exception, List<CategoriaDespesa>> {
  final CategoriasService categoriasService = CategoriasService();

  CategoriasDespesasStore() : super([]) {
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
}
