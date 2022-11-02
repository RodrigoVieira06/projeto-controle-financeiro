import 'package:projeto_controle_financeiro/services/services.dart';

class MovimentacoesController {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  MovimentacoesController();

  setMovimento({
    required String entity,
    required Map<String, dynamic> movimento,
  }) async {
    await movimentacoesService.setMovimento(entity, movimento);
  }

  updateMovimento({
    required String entity,
    required Map<String, dynamic> movimento,
  }) async {
    await movimentacoesService.updateMovimento(entity, movimento);
  }

  List<String> getFormasPagamento() {
    return [
      'Dinheiro',
      'Pix',
      'Débito',
      'Crédito',
    ];
  }
}
