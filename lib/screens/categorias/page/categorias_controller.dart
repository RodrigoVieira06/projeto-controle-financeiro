import 'package:projeto_controle_financeiro/services/services.dart';

class CategoriasController {
  CategoriasService categoriasService = CategoriasService();

  CategoriasController();

  setCategoriaDespesa(Map<String, dynamic> categoriaDespesa) async {
    await categoriasService.setCategoriaDespesa(
        'categoriasDespesas', categoriaDespesa);
  }

  setCategoriaFaturamento(Map<String, dynamic> categoriaFaturamento) async {
    await categoriasService.setCategoriaDespesa(
        'categoriasFaturamentos', categoriaFaturamento);
  }
}
