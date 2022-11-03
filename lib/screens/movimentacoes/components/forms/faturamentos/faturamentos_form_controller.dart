import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/models/models.dart';

class FaturamentosFormController {
  // inicio - definição de controladores dos campos do formulário
  final formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController observacoes = TextEditingController();
  // fim - definição de configurações dos campos do formulário

  // inicio - definição dos valores dos campos do formulário
  String? categoriaValue;
  // fim - definição dos valores dos campos do formulário

  // inicio - declaração de listas que serão utilizadas nos selects do formulário
  late final List<String> categoria;
  // fim - declaração de listas que serão utilizadas nos selects do formulário

  late final Faturamento? faturamento;

  FaturamentosFormController(Map<String, dynamic> dadosForm) {
    _getInitialData(dadosForm);
  }

  _getInitialData(Map<String, dynamic> dadosForm) {
    categoria = dadosForm['categoriasFaturamentos'];
    faturamento = dadosForm['faturamento'];

    if (faturamento != null) {
      titulo = TextEditingController(text: faturamento!.titulo);
      valor = TextEditingController(text: faturamento!.valor.toString());
      data = TextEditingController(
          text: DateFormat('dd/MM/yyyy')
              .format(DateTime.fromMillisecondsSinceEpoch(
        faturamento!.data.millisecondsSinceEpoch,
      )));
      categoriaValue = faturamento!.categoria;
      observacoes = TextEditingController(text: faturamento!.observacoes);
    }
  }
}
