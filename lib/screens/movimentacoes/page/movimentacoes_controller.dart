import 'package:projeto_controle_financeiro/services/services.dart';

class MovimentacoesController {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  MovimentacoesController();

  setFaturamento(Map<String, dynamic> faturamento) async {
    await movimentacoesService.setFaturamento(faturamento);
  }

  setDespesa(Map<String, dynamic> despesa) async {
    await movimentacoesService.setDespesa(despesa);
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
