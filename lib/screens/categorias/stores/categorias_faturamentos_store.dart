import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasFaturamentosStore
    extends NotifierStore<Exception, List<Categoria>> {
  final CategoriasService categoriasService = CategoriasService();

  CategoriasFaturamentosStore() : super([]) {
    getCategoriasFaturamentos();
  }

  getCategoriasFaturamentos() async {
    try {
      setLoading(true);
      List<Categoria> categoriasFaturamentos =
          await categoriasService.getCategoriasFaturamentos();
      update(categoriasFaturamentos);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
