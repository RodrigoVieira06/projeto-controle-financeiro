import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CartoesFormStore extends NotifierStore<Exception, Map<String, dynamic>> {
  final CartoesService cartoesService = CartoesService();
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  CartoesFormStore({
    String? id,
    required String entityName,
  }) : super({}) {
    getCartao(
      cartaoId: id,
      entityName: entityName,
    );
  }

  getCartao({
    String? cartaoId,
    required String entityName,
  }) async {
    try {
      setLoading(true);
      Map<String, dynamic> dadosForm;

      if (entityName == 'cartoesCredito') {
        CartaoCredito? cartao;

        if (cartaoId != null) {
          cartao = await cartoesService.getCartao(cartaoId, entityName);
        }
        dadosForm = {'cartao': cartao};
      } else {
        CartaoDebito? cartao;

        if (cartaoId != null) {
          cartao = await cartoesService.getCartao(cartaoId, entityName);
        }
        dadosForm = {'cartao': cartao};
      }

      update(dadosForm);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  setCartao({
    required String entityName,
    required Map<String, dynamic> entity,
  }) async {
    setLoading(true);
    await cartoesService.setCartao(entityName, entity);
    setLoading(false);
  }

  updateCartao({
    required String entityName,
    required Map<String, dynamic> entity,
  }) async {
    setLoading(true);
    await cartoesService.updateCartao(entityName, entity);
    setLoading(false);
  }

  deleteCartao(
    String entityName,
    Map<String, dynamic> entity,
  ) async {
    setLoading(true);
    await cartoesService.deleteCartao(entityName, entity);
    setLoading(false);
  }
}
