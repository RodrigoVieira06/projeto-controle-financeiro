import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class DespesasFormStore
    extends NotifierStore<Exception, Map<String, List<String>?>> {
  final CategoriasService categoriasService = CategoriasService();
  final CartoesService cartoesService = CartoesService();

  DespesasFormStore() : super({}) {
    getDados();
  }

  getDados() async {
    try {
      setLoading(true);

      List<CategoriaDespesa> categoriasDespesas =
          await categoriasService.getCategoriasDespesas();
      List<CartaoCredito> cartoesCredito =
          await cartoesService.getCartoesCredito();
      List<CartaoDebito> cartoesDebito =
          await cartoesService.getCartoesDebito();

      List<String> categoriasDespesasValues = [];
      List<String> cartoesCreditoValues = [];
      List<String> cartoesDebitoValues = [];

      for (var categoriaDespesa in categoriasDespesas) {
        categoriasDespesasValues.add(categoriaDespesa.titulo);
      }

      for (var cartaoCredito in cartoesCredito) {
        cartoesCreditoValues.add(cartaoCredito.titulo);
      }

      for (var cartaoDebito in cartoesDebito) {
        cartoesDebitoValues.add(cartaoDebito.titulo);
      }

      Map<String, List<String>?> dadosForm = {
        'categoriasDespesas': categoriasDespesasValues,
        'cartoesCredito': cartoesCreditoValues,
        'cartoesDebito': cartoesDebitoValues,
      };

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
