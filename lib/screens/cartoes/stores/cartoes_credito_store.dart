import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CartoesCreditoStore
    extends NotifierStore<Exception, List<CartaoCredito>> {
  final CartoesService cartoesService = CartoesService();

  CartoesCreditoStore() : super([]) {
    getCartoesCredito();
  }

  getCartoesCredito() async {
    try {
      setLoading(true);
      List<CartaoCredito> cartoesCredito =
          await cartoesService.getCartoesCredito();
      update(cartoesCredito);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
