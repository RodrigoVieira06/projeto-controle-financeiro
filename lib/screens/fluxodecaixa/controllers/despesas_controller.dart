import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/services/despesas_service.dart';

class DespesasController extends ChangeNotifier {
  DespesasService despesasService = DespesasService();
  List<Map<String, dynamic>> despesas = [];
  bool isLoading = false;

  DespesasController() {
    getDespesas();
  }

  getDespesas() async {
    isLoading = true;
    despesas = await despesasService.getDespesas();
    isLoading = false;
    notifyListeners();
  }
}
