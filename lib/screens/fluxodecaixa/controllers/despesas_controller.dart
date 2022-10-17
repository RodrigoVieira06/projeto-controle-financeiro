import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/services/despesas_service.dart';

class DespesasController extends ChangeNotifier {
  DespesasService despesasService = DespesasService();
  List<Map<String, dynamic>> _despesas = [];
  final loading = ValueNotifier(false);

  DespesasController() {
    getDespesas();
  }

  UnmodifiableListView<Map<String, dynamic>> get despesas =>
      UnmodifiableListView(_despesas);

  getDespesas() async {
    showLoading(true);
    _despesas = await despesasService.getDespesas();
    showLoading(false);
    notifyListeners();
  }

  setDespesa(Map<String, dynamic> despesa) async {
    await despesasService.setDespesa(despesa);
    getDespesas();
  }

  showLoading(bool valor) {
    loading.value = valor;
    notifyListeners();
  }
}
