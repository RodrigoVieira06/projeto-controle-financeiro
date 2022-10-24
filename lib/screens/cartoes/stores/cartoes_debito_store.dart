import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class CartoesDebitoStore extends NotifierStore<Exception, List<CartaoDebito>> {
  final CartoesService cartoesService = CartoesService();

  CartoesDebitoStore() : super([]) {
    getCartoesDebito();
  }

  getCartoesDebito() async {
    try {
      setLoading(true);
      List<CartaoDebito> cartoesDebito =
          await cartoesService.getCartoesDebito();
      update(cartoesDebito);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
