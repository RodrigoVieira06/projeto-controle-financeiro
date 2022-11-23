import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasFormStore
    extends NotifierStore<Exception, Map<String, dynamic>> {
  final CategoriasService categoriasService = CategoriasService();

  CategoriasFormStore({
    String? id,
    required String entityName,
  }) : super({}) {
    getCategoria(
      categoriaId: id,
      entityName: entityName,
    );
  }

  getCategoria({
    String? categoriaId,
    required String entityName,
  }) async {
    try {
      setLoading(true);

      Categoria? categorias;
      if (categoriaId != null) {
        categorias =
            await categoriasService.getCategoria(categoriaId, entityName);
      }

      Map<String, dynamic> dadosForm = {'categoria': categorias};

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  setCategoria({
    required String entityName,
    required Map<String, dynamic> entity,
  }) async {
    setLoading(true);
    await categoriasService.setCategoria(entityName, entity);
    setLoading(false);
  }

  updateCategoria({
    required String entityName,
    required Map<String, dynamic> entity,
  }) async {
    setLoading(true);
    await categoriasService.updateCategoria(entityName, entity);
    setLoading(false);
  }

  deleteCategoria(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    setLoading(true);
    await categoriasService.deleteCategoria(entityName, entity);
    setLoading(false);
  }
}
