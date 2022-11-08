import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasStore extends NotifierStore<Exception, List<Categoria>> {
  final CategoriasService categoriasService = CategoriasService();

  CategoriasStore(String entityName) : super([]) {
    getCategorias(entityName);
  }

  getCategorias(String entityName) async {
    try {
      setLoading(true);
      List<Categoria> categorias =
          await categoriasService.getCategorias(entityName);
      update(categorias);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
