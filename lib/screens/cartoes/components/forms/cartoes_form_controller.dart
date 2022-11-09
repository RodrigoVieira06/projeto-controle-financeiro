import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/models/models.dart';

class CartoesFormController {
  // inicio - definição de controladores dos campos do formulário
  final formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController diaVencimento = TextEditingController();
  TextEditingController descricao = TextEditingController();
  // fim - definição de configurações dos campos do formulário

  bool bloqueado = false;

  CartoesFormController(
    String entityName,
    Map<String, dynamic> dadosForm,
  ) {
    _getInitialData(entityName, dadosForm);
  }

  _getInitialData(
    String entityName,
    Map<String, dynamic> dadosForm,
  ) {
    if (entityName == 'cartoesCredito') {
      CartaoCredito? cartao = dadosForm['cartao'];

      if (cartao != null) {
        titulo = TextEditingController(text: cartao.titulo);
        diaVencimento =
            TextEditingController(text: cartao.diaVencimento.toString());
        descricao = TextEditingController(text: cartao.descricao);
        bloqueado = cartao.bloqueado;
      }
    } else {
      CartaoDebito? cartao = dadosForm['cartao'];

      if (cartao != null) {
        titulo = TextEditingController(text: cartao.titulo);
        descricao = TextEditingController(text: cartao.descricao);
        bloqueado = cartao.bloqueado;
      }
    }
  }
}
