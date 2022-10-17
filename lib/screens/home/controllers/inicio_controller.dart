import 'package:flutter/material.dart';

import '../../../services/services.dart';

class InicioController extends ChangeNotifier {
  DespesasService despesasService = DespesasService();
  FaturamentosService faturamentosService = FaturamentosService();
  num saldoAtual = 0;
  bool isLoading = false;

  InicioController() {
    getSaldoAtual();
  }

  getSaldoAtual() async {
    setLoading(true);
    List<Map<String, dynamic>> despesas = await despesasService.getDespesas();
    for (var despesa in despesas) {
      saldoAtual += despesa['valor'];
    }
    setLoading(false);
  }

  setLoading(bool valor) {
    isLoading = valor;
    notifyListeners();
  }
}
