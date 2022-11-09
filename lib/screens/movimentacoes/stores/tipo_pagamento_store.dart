import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class TipoPagamentoStore
    extends NotifierStore<Exception, Map<String, dynamic>> {
  final CartoesService cartoesService = CartoesService();

  TipoPagamentoStore()
      : super({
          'isCredit': false,
          'isDebit': false,
          'cartoes': {},
        });

  setTipoPagamento(bool isCredit, bool isDebit) async {
    try {
      setLoading(true);
      Map<String, dynamic> cartoes = {
        'isCredit': false,
        'isDebit': false,
        'cartoes': {},
      };
      if (isCredit) {
        List<CartaoCredito> cartoesCredito = [];
        cartoesCredito = await cartoesService.getCartoes('cartoesCredito');

        List<String> cartoesCreditoValues = [];

        for (var cartaoCredito in cartoesCredito) {
          cartoesCreditoValues.add(cartaoCredito.titulo);
        }

        cartoes = {
          'isCredit': isCredit,
          'isDebit': isDebit,
          'cartoes': cartoesCreditoValues,
        };
      } else if (isDebit) {
        List<CartaoDebito> cartoesDebito = [];
        cartoesDebito = await cartoesService.getCartoes('cartoesDebito');

        List<String> cartoesDebitoValues = [];

        for (var cartaoDebito in cartoesDebito) {
          cartoesDebitoValues.add(cartaoDebito.titulo);
        }

        cartoes = {
          'isCredit': isCredit,
          'isDebit': isDebit,
          'cartoes': cartoesDebitoValues,
        };
      }
      update(cartoes);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
