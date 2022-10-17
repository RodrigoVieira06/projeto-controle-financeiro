import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/services/faturamentos_service.dart';

class FaturamentosController extends ChangeNotifier {
  FaturamentosService faturamentosController = FaturamentosService();
  List<Map<String, dynamic>> faturamentos = [];
  bool isLoading = false;

  FaturamentosController() {
    _getFaturamentos();
  }

  _getFaturamentos() async {
    isLoading = true;
    faturamentos = await faturamentosController.getFaturamentos();
    isLoading = false;
    notifyListeners();
  }
}
