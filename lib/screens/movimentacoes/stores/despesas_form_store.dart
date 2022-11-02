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

      List<CategoriaDespesa> categoriasDespesas =
          await categoriasService.getCategoriasDespesas();
      List<CartaoCredito> cartoesCredito =
          await cartoesService.getCartoesCredito();
      List<CartaoDebito> cartoesDebito =
          await cartoesService.getCartoesDebito();
      Despesa? despesa;
      if (despesaId != null) {
        despesa = await movimentacoesService.getDespesa(despesaId);
      }

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

      Map<String, dynamic> dadosForm = {
        'categoriasDespesas': categoriasDespesasValues,
        'cartoesCredito': cartoesCreditoValues,
        'cartoesDebito': cartoesDebitoValues,
        'despesa': despesa
      };

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
