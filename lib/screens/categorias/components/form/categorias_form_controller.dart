import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/models/models.dart';

class CategoriasFormController {
  // inicio - definição de controladores dos campos do formulário
  final formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  // fim - definição de configurações dos campos do formulário

  bool bloqueado = false;

  late final Categoria? entity;

  CategoriasFormController(Map<String, dynamic> dadosForm) {
    _getInitialData(dadosForm);
  }

  _getInitialData(Map<String, dynamic> dadosForm) {
    entity = dadosForm['categoria'];

    if (entity != null) {
      titulo = TextEditingController(text: entity!.titulo);
      descricao = TextEditingController(text: entity!.descricao);
      bloqueado = entity!.bloqueado;
    }
  }
}
