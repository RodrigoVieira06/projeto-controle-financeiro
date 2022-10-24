import 'package:projeto_controle_financeiro/services/services.dart';

class CartoesController {
  final CartoesService cartoesService = CartoesService();

  CartoesController();

  setCartaoCredito(Map<String, dynamic> categoriaCredito) async {
    await cartoesService.setCartaoCredito(categoriaCredito);
  }

  setCartaoDebito(Map<String, dynamic> cartaoDebito) async {
    await cartoesService.setCartaoDebito(cartaoDebito);
  }
}
